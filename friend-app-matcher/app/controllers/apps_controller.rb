require 'will_paginate/array'

class AppsController < ApplicationController
  layout "applayout"

  # GET /apps
  # GET /apps.json
  def index
    @primary = current_user
    @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @primary = current_user
    @app = App.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.json
  def new
    @primary = current_user
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @primary = current_user
    @app = App.find(params[:id])
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(params[:app])

    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render json: @app, status: :created, location: @app }
      else
        format.html { render action: "new" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.json
  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  def like
    begin
      ActiveRecord::Base.transaction do
        @app = App.find(params[:id])
        @old_likes = @app.likes
        @user_app = @app.user_apps.where(:user_id => current_user.id)

        if @user_app.size == 0
          @user_app = UserApp.new(
              { user_id: current_user.id, app_id: params[:id]}, 
                  installed: false, liked: false )
        else
          @user_app = @user_app[0]
        end
    
        if @user_app.liked?
          @user_app.liked = false
          @app.likes -= 1
        else
          @user_app.liked = true
          @app.likes += 1
        end
        @app.save!
        @user_app.save!      
      end
    rescue ActiveRecord::RecordInvalid => e
      respond_to do |format|
        format.html { redirect_to apps_url }
        format.js { @likes = @old_likes
            @id = @app.id
            @error = true }
        format.json { head :no_content }
      end
    end
    respond_to do |format|
      format.html { redirect_to apps_url }
      format.js { @likes = @app.likes
           @id = @app.id 
           @error = false }
      format.json { head :no_content }
    end
  end

  def topapps
    # Links for pagination
    page = if params[:page]
             params[:page].to_i
           else
             page = 1
           end

    @primary = current_user

    app_count_total_size =  UserApp.joins(:app)
        .select("DISTINCT apps.app_id")
        .where(:installed => true)
        .count

    app_count = UserApp.joins(:app)
        .select("apps.app_id as app_app_id, apps.id, apps.likes, count(apps.app_id) as count")
        .where(:installed => true).group("apps.app_id").order("count(apps.app_id) DESC")
        .limit(10)
        .offset( (page - 1) * AppCount.per_page )

    @app_counts = Array.new(app_count_total_size)
    offset = (page - 1) * AppCount.per_page
    index = 0
    app_count.each do |app|
      @app_counts[offset + index] = AppCount.new(app_id: app.app_app_id, count: app.count, likes: app.likes, id: app.id)
      index += 1
    end

    @app_counts_display = @app_counts.paginate(page: page, per_page: AppCount.per_page)

    @page_left = nil
    @page_right = nil

    if app_count_total_size > AppCount.per_page
      if page == 1
        @page_right = page + 1
      elsif app_count_total_size < (AppCount.per_page * page)
        @page_left = page - 1
      else
        @page_right = page + 1
        @page_left = page - 1
      end
    end
  end

  def recommendations
    user = current_user
    @primary = user

    friendships = Friendship.includes(:friend => [ {:user_apps => :app}])
        .where(:user_id => current_user.id, :ignore => false)
    @app_counts = {}
    friendships.each do |friendship|
      friendship.friend.user_apps.each do |user_app|
        if !user_app.installed?
          next
        elsif @app_counts[user_app.app]
          @app_counts[user_app.app] += 1
        else
          @app_counts[user_app.app] = 1
        end
      end
    end
    # Remove apps that logged in user already has
    user.apps.each do |app|
      @app_counts.delete app
    end


    @app_counts_display = []
    @app_counts.each do |key, value|
      @app_counts_display << AppCount.new(app_id: key.app_id, 
          count: value, likes: key.likes, id: key.id)
    end

    @app_counts_display = @app_counts_display.sort_by { |appcount| appcount.count }.reverse
        .paginate(page: params[:page], per_page: AppCount.per_page)

    # Links for pagination
    page = if params[:page]
             params[:page].to_i
           else
             page = 1
           end

    @page_left = nil
    @page_right = nil

    if @app_counts.count > AppCount.per_page
      if page == 1
        @page_right = page + 1
      elsif @app_counts.count < (AppCount.per_page * page)
        @page_left = page - 1
      else
        @page_right = page + 1
        @page_left = page - 1
      end
    end
  end
end

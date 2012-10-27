class UserAppsController < ApplicationController
  # GET /user_apps
  # GET /user_apps.json
  def index
    @user_apps = UserApp.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_apps }
    end
  end

  # GET /user_apps/1
  # GET /user_apps/1.json
  def show
    @user_app = UserApp.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_app }
    end
  end

  # GET /user_apps/new
  # GET /user_apps/new.json
  def new
    @user_app = UserApp.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_app }
    end
  end

  # GET /user_apps/1/edit
  def edit
    @user_app = UserApp.find(params[:id])
  end

  # POST /user_apps
  # POST /user_apps.json
  def create
    # Receives a Facebook username and a list of Android package names.
    # The list of package names are delimited by newlines.
    @user_app = UserApp.new(params[:user_app])

    respond_to do |format|
      if @user_app.save
        format.html { redirect_to @user_app, notice: 'User app was successfully created.' }
        format.json { render json: @user_app, status: :created, location: @user_app }
      else
        format.html { render action: "new" }
        format.json { render json: @user_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_apps/1
  # PUT /user_apps/1.json
  def update
    @user_app = UserApp.find(params[:id])

    respond_to do |format|
      if @user_app.update_attributes(params[:user_app])
        format.html { redirect_to @user_app, notice: 'User app was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_apps/1
  # DELETE /user_apps/1.json
  def destroy
    @user_app = UserApp.find(params[:id])
    @user_app.destroy

    respond_to do |format|
      format.html { redirect_to user_apps_url }
      format.json { head :no_content }
    end
  end
end

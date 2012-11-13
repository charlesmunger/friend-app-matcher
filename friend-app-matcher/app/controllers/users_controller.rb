class UsersController < ApplicationController
  layout "applayout"

  # GET /users
  # GET /users.json
  def index
    redirect_to action: "show", id: current_user.id
    #@users = User.paginate page: params[:page],
    #    order: 'created_at desc', per_page: 10

    #respond_to do |format|
    #  format.html # index.html.erb
    #  format.json { render json: @users }
    #end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @primary = current_user

    @user = User.find(params[:id])
    @apps = @user.apps.paginate(page: params[:page])

    if @primary.id == @user.id or 
      @primary.friends.where(:id => @user.id).count != 0

      # Links for pagination
      page = if params[:page]
               params[:page].to_i
             else
               page = 1
             end

      @page_left = nil
      @page_right = nil

      if @user.apps.count > App.per_page
        if page == 1
          @page_right = page + 1
        elsif @apps.count < (App.per_page * page)
          @page_left = page - 1
        else
          @page_right = page + 1
          @page_left = page - 1
        end
      end

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @user }
      end
    else
      redirect_to friendships_url, 
        notice: "Can only view someone's apps if the person is your friend."
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @primary = current_user
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @primary = current_user
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to new_user_session_path }
      format.json { render json: { success: true } }
    end
  end
end

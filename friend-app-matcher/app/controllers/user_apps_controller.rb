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
    @user = User.find(:first, 
      :conditions => [ "uid = ?", params[:user_app][:uid].strip ])

    if @user.nil?
      respond_to do |format|
        error_message = {
          # Arbitrary error code at the moment
          code: 21,
          message: "Invalid uid: " + params[:user_app][:uid].strip
        }

        format.html { redirect_to user_apps_url }
        format.json { render json: error_message,
                      status: :unprocessable_entity }
      end

      # Exit after creating a response
      return
    end

    # List will be delimited by newlines
    packages_list = params[:user_app][:apps].strip.split("\n")

    # Packages that were successfully associated created with user
    @apps = []
    @user_apps = []
    packages_list.each do |package_name|
      app = App.find(:first, :conditions => [ "app_id = ?", package_name ])
      valid_app = !app.nil?

      # If app doesn't exist on our system, add it
      if app.nil?
        app = App.new({ app_id: package_name })
        valid_app = app.save
      end

      if valid_app
        user_app = UserApp.new({ user_id: @user.id, app_id: app.id })
        if user_app.save
          @apps << app
          @user_apps << user_app
        end
      end
    end

    respond_to do |format|
      format.html { redirect_to user_apps_url }
      format.json { render json: { user: @user, apps: @apps }, 
                           status: :created }
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

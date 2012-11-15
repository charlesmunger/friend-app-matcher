class FriendshipsController < ApplicationController
  layout "applayout"

  # GET /friends
  # GET /friends.json
  def index
    @user = current_user #User.find_by_id(session[:user_id])
    @friends = @user.friend_connections
    @friends = @friends.paginate(:conditions => {:ignore => false},
      :page => params[:page], :order => 'created_at DESC')

    @primary = @user

    # Links for pagination
    page = if params[:page]
             params[:page].to_i
           else
             page = 1
           end

    @page_left = nil
    @page_right = nil

    if @primary.friends.count > User.per_page
      if page == 1
        @page_right = page + 1
      elsif @friends.count < (User.per_page * page)
        @page_left = page - 1
      else
        @page_right = page + 1
        @page_left = page - 1
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end
  end

  # GET /friendships
  # GET /friendships.json
  def show
    redirect_to action: "index"
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @primary = current_user
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/edit
  def edit
    @primary = current_user
    @friends = @primary.friend_connections
    @friends = @friends.paginate(:page => params[:page], 
      :order => 'created_at DESC')

    # Links for pagination
    page = if params[:page]
             params[:page].to_i
           else
             page = 1
           end

    @page_left = nil
    @page_right = nil

    if @primary.friends.count > User.per_page
      if page == 1
        @page_right = page + 1
      elsif @friends.count < (User.per_page * page)
        @page_left = page - 1
      else
        @page_right = page + 1
        @page_left = page - 1
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end

  end

  # POST /friendships
  # POST /friends.json
  def create
    #@user = User.find(:first, 
    #  :conditions => [ "username = ?", params[:friendship][:user_id] ])

    @friend = User.find(:first,
      :conditions => [ "username = ?", params[:friendship][:friend_id] ])

    @friendship = Friendship.new({ 
      user_id: current_user.id, 
      friend_id: @friend.id,
      ignore: false
    })

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to friendships_url, notice: 'Friendship was successfully created.' }
        format.json { render json: @friendship, status: :created, location: @friendship }
      else
        format.html { render action: "new" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.json
  def update
    @friendship = Friendship.find(params[:id])

    if (params[:ignore])
      @friendship.ignore = params[:ignore] == "true"
    end

    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { render @friendship }
        format.json { render json: { success: true } }
      else
        format.html { render action: "index" }
        format.json { render json: @friendship.errors, 
                             status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to friendships_url }
      format.json { head :no_content }
    end
  end
end

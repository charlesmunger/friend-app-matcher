class FriendshipsController < ApplicationController
  # GET /friends
  # GET /friends.json
  def index
    @user = User.find_by_id(session[:user_id])
    @friends = @user.friends.paginate page: params[:page], order: 'created_at desc'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friends }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.json
  def show
    @friendship = Friendship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.json
  def new
    @friendship = Friendship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friends.json
  def create
    @user = User.find(:first, 
      :conditions => [ "username = ?", params[:friendship][:user_id] ])

    @friend = User.find(:first,
      :conditions => [ "username = ?", params[:friendship][:friend_id] ])

    @friendship = Friendship.new({ 
      user_id: @user.id, 
      friend_id: @friend.id 
    })

    respond_to do |format|
      if @friendship.save
        format.html { redirect_to @friendship, notice: 'Friendship was successfully created.' }
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

    respond_to do |format|
      if @friendship.update_attributes(params[:friend])
        format.html { redirect_to @friendship, notice: 'Friendship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
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

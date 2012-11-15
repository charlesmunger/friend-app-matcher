class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  #before_filter :authorize

  #protected

  #def authorize
  #  unless User.find_by_id(session[:user_id])
  #    redirect_to login_url, notice: "Please log in"
  #  end
  #end

  def after_sign_in_path_for(resource)
    # Fetch friends after each login.
    # Should not be here, we are misusing this function,
    # We should use https://github.com/hassox/warden
    graph = Koala::Facebook::API.new(request.env['omniauth.auth']['credentials']['token'])
    friends = graph.get_connections("me", "friends")
    Friendship.destroy_all(:user_id => current_user.id)
    uids = friends.collect { |f| f["id"] }
    uids.each do |uid|
      friend = User.find(:first,
                         :conditions => [ "uid = ?", uid ])
      if friend
        Friendship.new({ 
                         user_id: current_user.id, 
                         friend_id: friend.id
                       }).save
      end
    end
    super
  end

end

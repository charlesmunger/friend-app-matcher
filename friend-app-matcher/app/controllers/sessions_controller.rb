class SessionsController < ApplicationController
  skip_before_filter :authorize

  def new
    if session[:user_id]
      user = User.find_by_id(session[:user_id])
      redirect_to users_url + '/' + user.id.to_s
    end
  end

  def create
    user = User.find_by_username(params[:username])
    if user
      session[:user_id] = user.id
      redirect_to users_url + '/' + user.id.to_s
    else
      redirect_to login_url, alert: "Invalid username or password."
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end

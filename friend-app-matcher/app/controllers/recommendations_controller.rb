require 'will_paginate/array'

class RecommendationsController < ApplicationController
  def index
    user = User.find_by_id(session[:user_id])
    friends = user.friends
    @app_counts = {}
    friends.each do |friend|
      friend.apps.each do |app|
        if @app_counts[app]
          @app_counts[app] += 1
        else
          @app_counts[app] = 1
        end
      end
    end
    user.apps.each do |app|
      @app_counts.delete app
    end
    @app_counts = @app_counts.sort_by { |key, value| value}.reverse.paginate(:page => params[:page], :per_page => 10)
  end
end

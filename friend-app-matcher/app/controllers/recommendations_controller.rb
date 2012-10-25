class RecommendationsController < ApplicationController
  def index
    user = User.find_by_id(session[:user_id])
    friends = user.friends
    @appCounts = {}
    friends.each do |friend|
      friend.apps.each do |app|
        if @appCounts[app]
          @appCounts[app] += 1
        else
          @appCounts[app] = 1
        end
      end
    end
    @appCounts = @appCounts.sort_by { |key, value| value}.reverse
  end
end

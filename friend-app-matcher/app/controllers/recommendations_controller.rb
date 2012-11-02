require 'will_paginate/array'

class RecommendationsController < ApplicationController
  layout "applayout"

  def index
    user = current_user
    @primary = user

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

    # Remove apps that logged in user already has
    user.apps.each do |app|
      @app_counts.delete app
    end

    @app_counts_display = []
    @app_counts.each do |key, value|
      @app_counts_display << AppCount.new(app_id: key.app_id, count: value)
    end

    @app_counts_display = @app_counts_display.sort_by { |appcount| appcount.count }.reverse.paginate(page: params[:page], per_page: AppCount.per_page)

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

class TopappsController < ApplicationController
  layout "applayout"

  def index
    @primary = current_user

    apps = App.all
    @app_counts = []
    apps.each do |app|
      @app_counts << AppCount.new(app_id: app.app_id, 
        count: app.user_apps.count)
    end

    @app_counts = @app_counts.sort_by { |appcount| appcount.count }.reverse
    @app_counts_display = @app_counts.paginate(page: params[:page], 
      per_page: AppCount.per_page)

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

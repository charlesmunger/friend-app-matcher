class TopappsController < ApplicationController
  def index
    apps = App.all
    @app_counts = {}
    apps.each do |app|
      @app_counts[app] = app.user_apps.count
    end
    @app_counts = @app_counts.sort_by { |key, value| value}.reverse.paginate(:page => params[:page], :per_page => 10)
  end
end

class HomeController < ApplicationController
  layout "admin"
  skip_before_filter :require_login
  def index
    if logged_in?
      redirect_to app_path
    end
  end
end
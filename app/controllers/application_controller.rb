class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :require_login

  def not_authenticated
    redirect_to login_path, :alert => "First login to access this page."
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
end

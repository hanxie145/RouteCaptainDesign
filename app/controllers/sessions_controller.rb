class SessionsController < ApplicationController
  layout 'admin'
  skip_before_filter :require_login, :except => [:destroy]
  respond_to :json, :html

  def new
  end

  def create
    user = login(params[:email], params[:password])
    if user
      redirect_to app_path
    else
      flash[:error] = "Email or password was invalid"
      redirect_to login_path
    end
  end

  def destroy
    logout
    redirect_to root_url, :notice => "Logged out!"
  end

  def current
    respond_with current_user
  end

end
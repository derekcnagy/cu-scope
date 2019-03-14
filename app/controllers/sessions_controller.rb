class SessionsController < ApplicationController
  def index
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      log_in user
      redirect_to root_url
    else
      flash.alert = 'Invalid email/password combination'
      render 'index'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end

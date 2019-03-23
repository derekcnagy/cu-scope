class UserSettingsController < ApplicationController
  include UserSettingsHelper

  def index
    @user = User.find session[:user_id]
    @teams = Team.all
    @profiles = {}
    @teams.each do |team|
      @profiles[team[:id]] = Profile.where team_id: team[:id]
    end
    @user_type = UserType.find(session[:user_type])
  end

  def change_password
    user = User.find(session[:user_id])
    status = update_password(user: user, old_password: params[:old_password], new_password: params[:new_password],
                       password_confirmation: params[:password_confirmation])
    if status
      flash.alert = 'Password Changed'
      redirect_back(fallback_location: root_path)
    else
      flash.alert = 'Invalid email/password combination'
      redirect_back(fallback_location: root_path)
    end
  end
end

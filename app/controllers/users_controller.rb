class UsersController < ApplicationController

  def index
    @teams = Team.all
    @users = User.all
    @user_types = UserType.all
  end

  def update
    User.where(id: params[:id]).update_all(user_type_id: params[:user_type], username: params[:username],
                                           first_name: params[:first_name], last_name: params[:last_name],
                                           team_id: params[:team])

    redirect_back(fallback_location: root_path)
  end

  def destroy
    User.destroy params[:id]
    redirect_back(fallback_location: root_path)
  end

  def reset_password
    new_password = SecureRandom.alphanumeric 8
    user = User.find params[:id]
    user.password = new_password
    user.save
    flash.alert = "New Password For #{user.username}: #{new_password}"
    redirect_back(fallback_location: root_path)
  end
end

class NewUserController < ApplicationController
  include SessionsHelper

  def index
    @current_page = :users
    @teams = Team.all
  end

  def create
    unless User.find_by(username: params[:username]).nil?
      flash.alert = 'username used'
      redirect_back(fallback_location: root_path)
      return
    end
    user_type = User.all.size.eql?(0) ? UserType.find(1) : UserType.find(3)
    team = Team.find params[:team]
    user = User.new(username: params[:username], first_name: params[:first_name], last_name: params[:last_name],
                    password: params[:password], password_confirmation: params[:password_confirmation],
                    team: team, user_type: user_type)
    if user.save
      log_in user
      redirect_to root_url
    else
      flash.alert = 'user not created'
      redirect_back(fallback_location: root_path)
    end
  end
end

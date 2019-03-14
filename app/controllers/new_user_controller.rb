class NewUserController < ApplicationController

  def index
    @teams = Team.all
  end

  def create
    user_type = User.all.size.eql?(0) ? UserType.find(1) : UserType.find(4)
    team = Team.find params[:team]
    user = User.new(username: params[:username], first_name: params[:first_name], last_name: params[:last_name],
                    password: params[:password], password_confirmation: params[:password_confirmation],
                    team: team, user_type: user_type)
    user.save
  end
end

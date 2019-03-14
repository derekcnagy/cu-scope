class TeamsController < ApplicationController

  def index
    @teams = Team.all
  end

  def create
    team = Team.new
    team.team_name = params[:team_name]
    team.save
  end
end

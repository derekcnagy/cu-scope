class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
    @teams = Team.all
  end

  def create
    team = Team.find params[:team]
    profile = Profile.new(profile_name: params[:profile_name], team: team)
    profile.save
  end
end

class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all.order(:team_id)
    @teams = Team.all
    @team_names = {}
    @teams.each do |team|
      @team_names[team[:id]] = team[:team_name]
    end
  end

  def create
    team = Team.find params[:team]
    profile = Profile.new(profile_name: params[:profile_name], team: team)
    profile.save
    redirect_back(fallback_location: root_path)
  end

  def update
    Profile.where(id: params[:profile_id]).update(profile_name: params[:profile_name])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    profile = Profile.find params[:profile_id]
    team = Team.find profile[:team_id]

    TestRun.where(team_id: team[:id], profile_id: profile[:id]).each do |test_run|
      IndividualTest.where(test_run_id: test_run[:id]).destroy_all
      TestRun.destroy test_run[:id]
    end
    Profile.destroy params[:profile_id]

    redirect_back(fallback_location: root_path)
  end
end

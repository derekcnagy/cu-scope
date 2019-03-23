class TeamsController < ApplicationController

  def index
    @teams = Team.where.not(id: 1)
  end

  def create
    team = Team.new
    team.team_name = params[:team_name]
    team.save
    redirect_back(fallback_location: root_path)
  end

  def update
    Team.where(id: params[:team_id]).update(team_name: params[:team_name])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Team.destroy params[:team_id]
    Profile.where(team_id: params[:team_id]).destroy_all

    TestRun.where(team_id: params[:team_id]).each do |test_run|
      IndividualTest.where(test_run_id: test_run[:id]).destroy_all
      TestRun.destroy test_run[:id]
    end

    Feature.where(team_id: params[:team_id]).each do |feature|
      Scenario.where(feature_id: feature[:id]).destroy_all
      Feature.destroy feature[:id]
    end

    redirect_back(fallback_location: root_path)
  end
end

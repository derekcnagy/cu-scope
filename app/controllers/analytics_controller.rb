class AnalyticsController < ApplicationController
  include AnalyticsHelper

  def index
    profile = Profile.where(profile_name: 'Full Run', team_id: 1)
    puts 'Bad Wolf'
    puts profile
    puts profile.size
    puts profile.first

    profile = Profile.where(profile_name: 'Full Runs', team_id: 1)
    puts profile
    puts profile.size
    puts profile.first
    puts profile.first.nil?
puts '------------------------------'



    team_id = session[:team].nil? ? 1 : session[:team]
    team = Team.find team_id

    @teams = Team.all
    @most_failed_scenarios = most_failed_scenarios team
    @longest_running_tests = longest_running_tests team
    @most_common_errors = most_common_errors team

  end

  def change_team
    session[:team] = params[:team]
    session[:profile] = nil
    redirect_back(fallback_location: root_path)
  end
end

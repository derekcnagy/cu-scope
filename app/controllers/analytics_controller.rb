class AnalyticsController < ApplicationController
  include AnalyticsHelper

  def index
    team_id = session[:team].nil? ? 1 : session[:team]
    team = Team.find team_id

    @teams = Team.all
    @from_date = session[:from_date].nil? ? Date.today.to_datetime.strftime("%Y-%m-%d") : session[:from_date]
    @to_date = session[:to_date].nil? ? (Date.today - 30).to_datetime.strftime("%Y-%m-%d") : session[:to_date]
    @most_failed_scenarios = most_failed_scenarios team, @from_date, @to_date
    @longest_running_tests = longest_running_tests team, @from_date, @to_date
    @most_common_errors = most_common_errors team, @from_date, @to_date
  end

  def change_team_and_dates
    unless session[:team].eql? params[:team]
      session[:team] = params[:team]
      session[:profile] = nil
    end
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_back(fallback_location: root_path)
  end
end

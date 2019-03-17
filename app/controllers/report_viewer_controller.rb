class ReportViewerController < ApplicationController
  include ReportViewerHelper

  def index
    @from_date = session[:from_date].nil? ? (Date.today - 30).to_datetime.strftime("%Y-%m-%d") : session[:from_date]
    @to_date = session[:from_date].nil? ? Date.today.to_datetime.strftime("%Y-%m-%d") : session[:to_date]
    team_id = session[:team].nil? ? 1 : session[:team]
    @teams = Team.all
    @profiles = {}
    @teams.each do |team|
      @profiles[team[:id]] = Profile.where team_id: team[:id]
    end
    report = build_report(team_id, session[:profile], @from_date, @to_date)
    @test_run_times = report[:test_run_times]
    @test_data = report[:test_data]
  end

  def view_report
    team = params[:team]
    profile = "profile_team_#{team}"
    session[:team] = team
    session[:profile] = profile
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_back(fallback_location: root_path)
  end
end

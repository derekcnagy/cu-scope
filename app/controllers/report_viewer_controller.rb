class ReportViewerController < ApplicationController
  include ReportViewerHelper

  def index
    @from_date = session[:from_date].nil? ? (Date.today - 30).to_datetime.strftime("%Y-%m-%d") : session[:from_date]
    @to_date = session[:from_date].nil? ? Date.today.to_datetime.strftime("%Y-%m-%d") : session[:to_date]
    team_id = session[:team].nil? ? 1 : session[:team]
    @teams = Team.all
    @profiles = Profile.where(team_id: team_id)
    report = build_report(team_id, session[:profile], @from_date, @to_date)
    @test_run_times = report[:test_run_times]
    @test_data = report[:test_data]
  end

  def change_team
    session[:team] = params[:team]
    session[:profile] = nil
    redirect_back(fallback_location: root_path)
  end

  def change_profile
    session[:profile] = params[:profile]
    redirect_back(fallback_location: root_path)
  end

  def change_date_range
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_back(fallback_location: root_path)
  end
end

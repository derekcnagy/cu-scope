require 'json'

class FileUploaderController < ApplicationController
  include FileUploaderHelper

  def index
    directory_path = 'public/report_jsons/'
    files = Dir["#{directory_path}*"]
    files.collect! {|file_name| file_name.gsub directory_path, ''}

    @files_to_process = []

    files.each do |file|
      file_name = file.gsub '.json', ''
      file_components = file_name.split '-'

      team = find_team file_components
      profile = find_profile file_components, team
      time_ran = find_time_ran file_components
      file_hash = {file_name: file, time_ran: time_ran, team: team, profile: profile}
      @files_to_process.push file_hash
    end

    @teams = Team.all
    @profiles = {}
    @teams.each do |team|
      @profiles[team[:id]] = Profile.where team_id: team[:id]
    end
  end

  def upload
    report_file_uploader = ReportFileUploader.new
    report_file_uploader.store!(params['upload'])
    redirect_back(fallback_location: root_path)
  end

  def process_file
    team = params[:team]
    profile = params["profile_team_#{team}"]
    report_data = JSON.parse File.read "public/report_jsons/#{params[:file_name]}"
    store_test_run report_data: report_data, time_ran: params[:time_ran],
                   file_name: params[:file_name], team: team, profile: profile
    File.delete "public/report_jsons/#{params[:file_name]}"
    redirect_back(fallback_location: root_path)
  end
end

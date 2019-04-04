class NotesController < ApplicationController
  include Pagy::Backend

  def index
    @current_page = :notes
    team_id = session[:team].nil? ? 1 : session[:team]

    @teams = Team.all
    @from_date = session[:from_date].nil? ? Date.today.to_datetime.strftime("%Y-%m-%d") : session[:from_date]
    @to_date = session[:to_date].nil? ? (Date.today - 30).to_datetime.strftime("%Y-%m-%d") : session[:to_date]
    notes_in_team_and_date_range = Note.where('team_id = ? and last_date_invoked Between ? and ?', team_id, @to_date, @from_date).collect{|note| note.id}

    @notes_for_scenario = Note.where('scenario_id is not null and id in(?)', notes_in_team_and_date_range)
    @notes_for_individual_test = Note.where('individual_test_id is not null and id in(?)', notes_in_team_and_date_range)
    @notes_for_error_message = Note.where('error_message_id is not null and individual_test_id is null and scenario_id is null and id in(?)', notes_in_team_and_date_range)

    @scenarios = {}
    Scenario.where('id in (?)', @notes_for_scenario.collect {|note| note.scenario_id}).each do |scenario|
      feature = Feature.find scenario.feature_id
      @scenarios[scenario.id] = {feature: feature.feature_name, scenario: scenario.scenario_name}
    end
    @individual_tests = {}
    IndividualTest.where('id in (?)', @notes_for_individual_test.collect {|note| note.individual_test_id}).each do |individual_test|
      test_run = TestRun.find individual_test.test_run_id
      @individual_tests[individual_test.id] = {
          feature: Feature.find(Scenario.find(individual_test.scenario_id).feature_id).feature_name,
          scenario: Scenario.find(individual_test.scenario_id).scenario_name,
          time_ran: test_run.time_ran}
    end
    @error_messages = {}
    error_message_ids = @notes_for_scenario.collect {|note| note.error_message_id}
    error_message_ids += @notes_for_error_message.collect {|note| note.error_message_id}
    error_message_ids += @notes_for_individual_test.collect {|note| note.error_message_id}
    ErrorMessage.where('id in (?)', error_message_ids).each do |error_message|
      @error_messages[error_message.id] = error_message.error_message
    end
  end

  def create
    date_created = DateTime.now.to_datetime.strftime("%Y-%m-%dT%H:%M")
    last_date_invoked = TestRun.find(IndividualTest.find(params[:test]).test_run_id).time_ran
    note = Note.new(note: params[:note], team_id: session[:team], user_id: session[:user_id],
                    error_message_id: params[:error_message], date_created: date_created,
                    last_date_invoked: last_date_invoked)
    case params[:note_for]
    when 'scenario'
      note.scenario_id = params[:scenario]
    when 'test'
      note.individual_test_id = params[:test]
    end
    note.save
  end

  def destroy
    Note.destroy params[:id]
    redirect_back(fallback_location: root_path)
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

class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def create

    puts "Bad WOlf"
    note = Note.new(note: params[:note], team_id: session[:team], user_id: session[:user_id], error_message_id: params[:error_message])
    case params[:note_for]
    when "Scenario"
      note.scenario_id = params[:scenario]
    when "Test"
      note.individual_test_id = params[:test]
    end
    puts "Note: #{note.note}"
    puts "Team: #{note.team_id}"
    puts "User: #{note.user_id}"
    puts "Error Message: #{note.error_message_id}"
    puts "Test: #{note.individual_test_id}"
    puts "Scenario: #{note.scenario_id}"
    puts '----------------------'
    note.save
  end
end

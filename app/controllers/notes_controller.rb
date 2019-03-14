class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def create
    test = IndividualTest.find params[:test]
    team = Team.find params[:team]
    user = User.find session[:user_id]
    error_message = ErrorMessage.find params[:error_message]

    note = Note.new(note: params[:note], team: team, user: user, error_message: error_message)
    case params[:note_for]
    when "Scenario"
      note.scenarios = Scenario.find params[:scenario]
    when "Test"
      note.tests = test
    end
    note.save
  end
end

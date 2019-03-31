class NotesController < ApplicationController

  def index
    @notes = Note.all
  end

  def create
    note = Note.new(note: params[:note], team_id: session[:team], user_id: session[:user_id], error_message_id: params[:error_message])
    case params[:note_for]
    when 'scenario'
      note.scenario_id = params[:scenario]
    when 'test'
      note.individual_test_id = params[:test]
    end
    note.save
  end
end

class TestRunsController < ApplicationController
  include Pagy::Backend

  def index
    @current_page = :test_runs
    @pagy_test_runs, @test_runs = pagy(TestRun.all.order(time_ran: :desc))

    @teams_list = {}
    Team.all.each do |team|
      @teams_list[team.id] = team.team_name
    end
    @profiles_list = {}
    Profile.all.each do |profile|
      @profiles_list[profile.id] = profile.profile_name
    end
  end

  def destroy
    TestRun.destroy params[:id]
    IndividualTest.where(test_run_id: params[:id]).each do |individual_test|
      Note.find_by(individual_test_id: individual_test.id).destroy_all
      IndividualTest.destroy individual_test.id
    end
    redirect_back(fallback_location: root_path)
  end
end

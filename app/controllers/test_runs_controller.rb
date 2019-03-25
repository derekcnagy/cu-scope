class TestRunsController < ApplicationController
  include Pagy::Backend

  def index
    @pagy_test_runs, @test_runs = pagy(TestRun.all.order(time_ran: :desc))

    @teams = {}
    Team.all.each do |team|
      @teams[team.id] = team.team_name
    end
    @profiles = {}
    Profile.all.each do |profile|
      @profiles[profile.id] = profile.profile_name
    end
  end

  def destroy
    TestRun.destroy params[:id]
    IndividualTest.where(test_run_id: params[:id]).destroy_all
    redirect_back(fallback_location: root_path)
  end
end

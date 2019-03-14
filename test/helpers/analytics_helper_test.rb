require 'test_helper'

class AnalyticsHelperTest < ActiveSupport::TestCase
  include AnalyticsHelper

  setup do
    first_test_run = test_runs :first_test_run
    second_test_run = test_runs :second_test_run
    third_test_run = test_runs :third_test_run

    first_test_run.time_ran = (Date.today - 31).to_datetime
    first_test_run.save
    second_test_run.time_ran = (Date.today - 29).to_datetime
    second_test_run.save
    third_test_run.time_ran = Date.today.to_datetime
    third_test_run.save
  end

  test 'Most Failed Scenarios returns all the scenarios of a team along with how often each fails, but only the last 30 days' do
    scenarios = {}
    scenarios['First Scenario'] = 50
    scenarios['Second Scenario'] = 0
    scenarios['Third Scenario'] = 50
    scenarios['Forth Scenario'] = 0
    scenarios['Fifth Scenario'] = 100

    most_failed = most_failed_scenarios teams(:team_one)
    assert most_failed.size.eql? 5
    most_failed.each do |id, scenario_data|
      percent = scenarios[scenario_data[:scenario_name]]
      assert scenario_data[:test_fail_percent].eql? percent
    end
  end

  test 'Longest Running Tests returns all the scenarios of a team along with there average run time and how it compares to the average, but only the last 30 days' do
    scenarios = {}
    scenarios['First Scenario'] = {duration: 100, compared_to_average: 58}
    scenarios['Second Scenario'] = {duration: 150, compared_to_average: 88}
    scenarios['Third Scenario'] = {duration: 150, compared_to_average: 88}
    scenarios['Forth Scenario'] = {duration: 250, compared_to_average: 147}
    scenarios['Fifth Scenario'] = {duration: 200, compared_to_average: 117}

    longest_running = longest_running_tests teams(:team_one)
    assert longest_running.size.eql? 5
    longest_running.each do |id, scenario_data|
      duration = scenarios[scenario_data[:scenario_name]][:duration]
      compared_to_average = scenarios[scenario_data[:scenario_name]][:compared_to_average]
      assert scenario_data[:duration].eql? duration
      assert scenario_data[:compared_to_average].eql? compared_to_average
    end
  end
  test 'Most Common Errors returns all the errors experienced by scenarios of a team along with how often each occurs, but only the last 30 days' do
    errors = {}
    errors['First Failure (RuntimeError)'] = 3
    errors['Second Failure (RuntimeError)'] = 1

    common_errors = most_common_errors teams(:team_one)
    assert common_errors.size.eql? 2
    common_errors.each do |id, error_data|
      error_count = errors[error_data[:error_message]]
      assert error_data[:error_count].eql? error_count
    end
  end
end
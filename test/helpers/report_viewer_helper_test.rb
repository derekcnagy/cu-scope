require 'test_helper'

class ReportViewerHelperTest < ActiveSupport::TestCase
  include ReportViewerHelper
  setup do

  end

  test 'Note data will return all the notes for the scenarios, the test, and the errors' do
    scenario_id = scenarios :first_scenario
    test_id = individual_tests :first_test_run_third_scenario
    error_message_id = error_messages :third_failure

    notes = note_data scenario_id, test_id, error_message_id

    assert notes['Test Notes'].size.eql? 1
    assert notes['Scenario Notes'].size.eql? 1
    assert notes['Error Notes'].size.eql? 1
    assert notes['Test Notes'].first.eql? 'this is a note for the an individual test'
    assert notes['Scenario Notes'].first.eql? 'this is a note for the a scenario'
    assert notes['Error Notes'].first.eql? 'this is a note for the an error'
  end

  test 'Scenario data will return all the scenario data for the feature and test runs' do
    feature = features :first_feature
    test_runs = [test_runs(:first_test_run), test_runs(:second_test_run), test_runs(:third_test_run)]

    data = scenario_data feature.id, test_runs

    assert data['first-feature;first-scenario'][:scenario_tests][0][:passed].eql? false
    assert data['first-feature;first-scenario'][:scenario_tests][0][:duration].eql? 300000000000
    assert data['first-feature;first-scenario'][:scenario_tests][0][:error_message].eql? 'First Failure (RuntimeError)'
    assert data['first-feature;first-scenario'][:scenario_tests][1][:passed].eql? false
    assert data['first-feature;first-scenario'][:scenario_tests][1][:duration].eql? 100000000000
    assert data['first-feature;first-scenario'][:scenario_tests][1][:error_message].eql? 'First Failure (RuntimeError)'
    assert data['first-feature;first-scenario'][:scenario_tests][2][:passed].eql? true
    assert data['first-feature;first-scenario'][:scenario_tests][2][:duration].eql? 100000000000
    assert data['first-feature;first-scenario'][:scenario_tests][2][:error_message].nil?

    assert data['first-feature;second-scenario'][:scenario_tests][0][:passed].eql? true
    assert data['first-feature;second-scenario'][:scenario_tests][0][:duration].eql? 400000000000
    assert data['first-feature;second-scenario'][:scenario_tests][0][:error_message].nil?
    assert data['first-feature;second-scenario'][:scenario_tests][1][:passed].eql? true
    assert data['first-feature;second-scenario'][:scenario_tests][1][:duration].eql? 200000000000
    assert data['first-feature;second-scenario'][:scenario_tests][1][:error_message].nil?
    assert data['first-feature;second-scenario'][:scenario_tests][2][:passed].eql? true
    assert data['first-feature;second-scenario'][:scenario_tests][2][:duration].eql? 100000000000
    assert data['first-feature;second-scenario'][:scenario_tests][2][:error_message].nil?

    assert data['first-feature;third-scenario'][:scenario_tests][0][:passed].eql? false
    assert data['first-feature;third-scenario'][:scenario_tests][0][:duration].eql? 0
    assert data['first-feature;third-scenario'][:scenario_tests][0][:error_message].eql? 'Second Failure (RuntimeError)'
    assert data['first-feature;third-scenario'][:scenario_tests][1][:passed].eql? true
    assert data['first-feature;third-scenario'][:scenario_tests][1][:duration].eql? 100000000000
    assert data['first-feature;third-scenario'][:scenario_tests][1][:error_message].nil?
    assert data['first-feature;third-scenario'][:scenario_tests][2][:passed].eql? false
    assert data['first-feature;third-scenario'][:scenario_tests][2][:duration].eql? 200000000000
    assert data['first-feature;third-scenario'][:scenario_tests][2][:error_message].eql? 'First Failure (RuntimeError)'
  end

  test 'Build report will return all the report data for the team and profile from the last 30 days' do
    first_test_run = test_runs :first_test_run
    second_test_run = test_runs :second_test_run
    third_test_run = test_runs :third_test_run

    first_test_run_time_ran = (Date.today - 31).to_datetime
    second_test_run_time_ran = (Date.today - 29).to_datetime
    third_test_run_time_ran = Date.today.to_datetime

    first_test_run.time_ran = first_test_run_time_ran
    first_test_run.save
    second_test_run.time_ran = second_test_run_time_ran
    second_test_run.save
    third_test_run.time_ran = third_test_run_time_ran
    third_test_run.save

    team_id = teams :team_one
    profile_id = nil
    report = build_report team_id, profile_id
    test_run_times = report[:test_run_times]
    test_data = report[:test_data]

    assert DateTime.strptime(test_run_times[0], '%m/%d/%Y %H:%M:%S').eql? third_test_run_time_ran.to_datetime
    assert DateTime.strptime(test_run_times[1], '%m/%d/%Y %H:%M:%S').eql? second_test_run_time_ran.to_datetime
    assert test_data['second-feature'].class.eql? Hash
    assert test_data['first-feature'].class.eql? Hash
  end
end

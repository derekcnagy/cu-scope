require 'test_helper'

class FileUploaderHelperTest < ActiveSupport::TestCase
  include FileUploaderHelper

  setup do
    steps = [{'keyword' => 'Given ', 'name' => 'first given step', 'line' => 9,
              'match' => {'location' => "features/step_definitions/second_feature_steps.rb:1"},
              'result' => {'status' => 'passed', 'duration' => 35740}},
             {'keyword' => 'When ', 'name' => 'first when step', 'line' => 10,
              'match' => {'location' => 'features/step_definitions/second_feature_steps.rb:4'},
              'result' => {'status' => "passed", 'duration' => 32892}},
             {'keyword' => 'Then ', "name" => "first then step", "line" => 11,
              'match' => {'location' => 'features/step_definitions/first_feature_steps.rb:67'},
              'result' => {'status' => 'passed', 'duration' => 28320}}]

    @scenario_data = {'id' => 'the-feature-name;the-scenario-name', 'keyword' => 'Scenario', 'name' => 'The Scenario Name',
                      'description' => '', 'line' => 8, 'type' => 'scenario', 'steps' => steps}
    @feature_data = {"uri"=>"/home/derek/RubymineProjects/test_cucumber_project/features/second_feature.feature",
                     "id"=>"the-feature-name", "keyword"=>"Feature", "name"=>"The Feature Name", "description"=>"",
                     "line"=>1, "elements"=>[@scenario_data]}
    @test_run_data = [@feature_data]
  end

  test 'Should the description of a feature change update_feature will update the feature data' do
    new_description = 'A new Description'
    new_data = {'uri' => 'features/second_feature.feature', 'id' => 'first-feature', 'keyword' => 'Feature',
                'name' => 'First Feature', 'description' => new_description, 'line' => 1}

    current_data = features :first_feature

    update_feature current_data, new_data

    feature_data = Feature.find features(:first_feature).id

    assert feature_data.feature_description.eql? new_description
  end

  test 'If the description of a feature did not change update_feature will Not update the feature data' do
    current_data = features :first_feature
    current_description = current_data.feature_description
    new_data = {'uri' => 'features/second_feature.feature', 'id' => 'first-feature', 'keyword' => 'Feature',
                'name' => 'First Feature', 'description' => current_description, 'line' => 1}

    update_feature current_data, new_data

    feature_data = Feature.find features(:first_feature).id

    assert feature_data.feature_description.eql? current_description
  end


  test 'Should the description of a Scenario change update_scenario will update the scenario data' do
    current_data = scenarios :first_scenario
    new_description = 'A new Description'
    @scenario_data['description'] = new_description

    update_scenario current_data, @scenario_data
    scenario_data = Scenario.find scenarios(:first_scenario).id

    assert scenario_data.scenario_description.eql? new_description
  end

  test 'If the description of a Scenario did not change update_scenario will Not update the scenario data' do
    current_data = scenarios :first_scenario
    current_description = current_data.scenario_description
    @scenario_data['description'] = current_description

    update_scenario current_data, @scenario_data
    scenario_data = Scenario.find scenarios(:first_scenario).id

    assert scenario_data.scenario_description.eql? current_description
  end

  test 'Should the steps of a Scenario changed update_scenario will update the scenario data' do
    @scenario_data['steps'] = [{'keyword' => 'Given ', 'name' => 'new given step', 'line' => 9,
                  'match' => {'location' => "features/step_definitions/second_feature_steps.rb:1"},
                  'result' => {'status' => 'passed', 'duration' => 35740}},
                 {'keyword' => 'When ', 'name' => 'new when step', 'line' => 10,
                  'match' => {'location' => 'features/step_definitions/second_feature_steps.rb:4'},
                  'result' => {'status' => "passed", 'duration' => 32892}},
                 {'keyword' => 'Then ', "name" => "new then step", "line" => 11,
                  'match' => {'location' => 'features/step_definitions/first_feature_steps.rb:67'},
                  'result' => {'status' => 'passed', 'duration' => 28320}}]
    current_data = scenarios :first_scenario
    new_steps = "Given new given step\nWhen new when step\nThen new then step"

    update_scenario current_data, @scenario_data
    scenario_data = Scenario.find scenarios(:first_scenario).id

    assert scenario_data.steps.eql? new_steps
  end

  test 'If the steps of a Scenario did not change update_scenario will Not update the scenario data' do
    current_data = scenarios :first_scenario
    current_steps = "Given first given step\nWhen first when step\nThen first then step"

    update_scenario current_data, @scenario_data
    scenario_data = Scenario.find scenarios(:first_scenario).id

    assert scenario_data.steps.eql? current_steps
  end

  test 'If there is a new error message it will be recorded' do
    new_error_message = 'A New Error'
    store_error_message new_error_message
    error_message = ErrorMessage.find_by error_message: new_error_message
    assert error_message.error_message.eql? new_error_message
  end

  test 'If the error message is already recorded it will not be rerecorded' do
    existing_error_message = error_messages(:first_failure).error_message
    store_error_message existing_error_message
    error_message = ErrorMessage.where error_message: existing_error_message
    assert error_message.size.eql? 1
  end

  test 'Store Test will store the test' do
    scenario = scenarios :first_scenario
    test_run = test_runs :first_test_run
    test = store_test @scenario_data, scenario, test_run
    test_data = IndividualTest.find test.id
    assert test_data.passed
  end

  test 'Store Scenario will store the scenario' do
    feature = features :first_feature
    scenario = store_scenario @scenario_data, feature
    scenario_data = Scenario.find scenario.id
    assert scenario_data.scenario_name.eql? 'The Scenario Name'
  end

  test 'If the Scenario is already recorded it will not be rerecorded but will update the existing' do
    @scenario_data['steps'] = [{'keyword' => 'Given ', 'name' => 'new given step', 'line' => 9,
                                'match' => {'location' => "features/step_definitions/second_feature_steps.rb:1"},
                                'result' => {'status' => 'passed', 'duration' => 35740}},
                               {'keyword' => 'When ', 'name' => 'new when step', 'line' => 10,
                                'match' => {'location' => 'features/step_definitions/second_feature_steps.rb:4'},
                                'result' => {'status' => "passed", 'duration' => 32892}},
                               {'keyword' => 'Then ', "name" => "new then step", "line" => 11,
                                'match' => {'location' => 'features/step_definitions/first_feature_steps.rb:67'},
                                'result' => {'status' => 'passed', 'duration' => 28320}}]
    existing_json_scenario_id = scenarios(:first_scenario).json_scenario_id
    @scenario_data['id'] = existing_json_scenario_id

    new_steps = "Given new given step\nWhen new when step\nThen new then step"

    feature = features :first_feature
    scenario = store_scenario @scenario_data, feature
    scenario_data = Scenario.where json_scenario_id: scenario.json_scenario_id
    assert scenario_data.size.eql? 1
    assert scenario_data.first.steps.eql? new_steps
  end

  test 'Store Feature will store the Feature' do
    team = teams(:team_one).id
    feature = store_feature @feature_data, team
    feature_data = Feature.find feature.id
    assert feature_data.feature_name.eql? 'The Feature Name'
  end

  test 'If the Feature is already recorded it will not be rerecorded but will update the existing' do
    existing_json_feature_id = features(:first_feature).json_feature_id
    new_description = "A new Feature Description"
    @feature_data['id'] = existing_json_feature_id
    @feature_data['description'] = new_description
    team = teams(:team_one).id

    feature = store_feature @feature_data, team
    feature_data = Feature.where json_feature_id: feature.json_feature_id
    assert feature_data.size.eql? 1
    assert feature_data.first.feature_description.eql? new_description
  end

  test 'Store Test Run will store the test run' do
    time_ran = '2019-01-30T12:46'
    file_name = 'a_test_run_file.json'
    team = teams(:team_one).id
    profile = nil
    store_test_run report_data: @test_run_data, time_ran: time_ran, file_name: file_name, team: team, profile: profile
    test_run = TestRun.find_by test_run_name: file_name
    assert test_run.test_run_name.eql? file_name
    assert test_run.time_ran.to_datetime.eql? time_ran.to_datetime
    assert test_run.team_id.eql? team
    assert test_run.profile.eql? profile
  end

end
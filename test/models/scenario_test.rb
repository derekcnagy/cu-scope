require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase
  setup do
    @scenario = Scenario.new
    @scenario.scenario_name = 'A Scenario'
    @scenario.steps = 'Given a given step'
    @scenario.json_scenario_id = 'first-feature;my-first-scenario'
    @scenario.feature = features :first_feature
  end
  test 'A new Scenario can be created' do
    assert @scenario.save
  end
  test 'A Scenario can have a Description' do
    @scenario.scenario_description = 'A Scenario Description'
    assert @scenario.save
  end
  test 'A Scenario requires a Scenario Name' do
    @scenario.scenario_name = ''
    assert_not @scenario.save
  end
  test 'A Scenario requires Steps' do
    @scenario.steps = ''
    assert_not @scenario.save
  end
  test 'A Scenario requires a JSON Scenario ID' do
    @scenario.json_scenario_id = ''
    assert_not @scenario.save
  end
  test 'A Scenario requires an associated Feature' do
    @scenario.feature = nil
    assert_not @scenario.save
  end
end

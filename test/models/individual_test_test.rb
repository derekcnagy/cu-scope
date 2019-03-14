require 'test_helper'

class IndividualTestTest < ActiveSupport::TestCase
  setup do
    @individual_test = IndividualTest.new
    @individual_test.passed = true
    @individual_test.duration = 100
    @individual_test.test_run = test_runs :first_test_run
    @individual_test.scenario = scenarios :first_scenario
  end

  test 'A New Failing Individual Test can be Created' do
    @individual_test.passed = false
    @individual_test.error_message = error_messages :first_failure
    assert @individual_test.save
  end
  test 'A New Passing Individual Test can be Created' do
    @individual_test.passed = true
    @individual_test.error_message = nil
    assert @individual_test.save
  end
  test 'A Failing Test must have an error_message' do
    @individual_test.passed = false
    @individual_test.error_message = nil
    assert_not @individual_test.save
  end
  test 'A Passing Test can NOT have an error_message' do
    @individual_test.passed = true
    @individual_test.error_message = error_messages :first_failure
    assert_not @individual_test.save
  end
  test 'A Test needs the Duration' do
    @individual_test.duration = nil
    assert_not @individual_test.save
  end
  test 'A Test needs the Test Run' do
    @individual_test.test_run = nil
    assert_not @individual_test.save
  end
  test 'A Test needs the Scenario' do
    @individual_test.scenario = nil
    assert_not @individual_test.save
  end
end

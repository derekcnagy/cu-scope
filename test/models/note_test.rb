require 'test_helper'

class NoteTest < ActiveSupport::TestCase
  setup do
    @note = Note.new
    @note.user = users :admin
    @note.note = 'A note'
    @note.team = teams :team_one
  end
  test "A Note can be attached to a Scenario" do
    @note.scenario = scenarios :first_scenario
    assert @note.save
  end
  test "A Note can be attached to an Individual Test" do
    @note.individual_test = individual_tests :a_passing_test
    assert @note.save
  end
  test "A Note can be attached to an Error Message" do
    @note.error_message = error_messages :first_failure
    assert @note.save
  end
  test 'A note needs to be attached to either a Scenario, an Individual Test, or an Error Message' do
    assert_not @note.save
  end
  test 'A note can NOT be attached to more then one of either a Scenario, an Individual Test, or an Error Message' do
    @note.scenario = scenarios :first_scenario
    @note.individual_test = individual_tests :a_passing_test
    @note.error_message = error_messages :first_failure
    assert_not @note.save

    @note.scenario = nil
    @note.individual_test = individual_tests :a_passing_test
    @note.error_message = error_messages :first_failure
    assert_not @note.save

    @note.scenario = scenarios :first_scenario
    @note.individual_test = nil
    @note.error_message = error_messages :first_failure
    assert_not @note.save

    @note.scenario = scenarios :first_scenario
    @note.individual_test = individual_tests :a_passing_test
    @note.error_message = nil
    assert_not @note.save
  end
  test 'A Note requires a user' do
    @note.user = nil
    assert_not @note.save
  end
  test 'A Note requires a note' do
    @note.note = ''
    assert_not @note.save
  end
  test 'A Note requires an associated Team' do
    @note.scenario = scenarios :first_scenario
    @note.team = nil
    assert_not @note.save
  end
end

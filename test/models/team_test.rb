require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  setup do
    @team = Team.new
    @team.team_name = 'A Team'
  end
  test 'A new Team can be created' do
    assert @team.save
  end
  test 'A Team requires a Name' do
    @team.team_name = ''
    assert_not @team.save
  end
end

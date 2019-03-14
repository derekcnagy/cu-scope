require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  setup do
    @profile = Profile.new
    @profile.profile_name = 'A Profile'
    @profile.team = teams :no_team
  end
  test 'A Profile can be created' do
    assert @profile.save
  end
  test 'A Profile needs a Profile Name' do
    @profile.profile_name = ''
    assert_not @profile.save
  end
  test 'A Profile can be associated with a Team' do
    @profile.team = teams :team_one
    assert @profile.save
  end
end

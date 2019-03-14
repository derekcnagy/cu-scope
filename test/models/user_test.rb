require 'test_helper'

class UserTest < ActiveSupport::TestCase

  setup do
    @user = User.new
    @user.username = 'testuser'
    @user.first_name = 'Test'
    @user.last_name = 'User'
    @user.user_type = user_types :viewer
    @user.password = 'password'
    @user.password_confirmation = 'password'
    @user.profile = profiles :smoke
    @user.team = teams :team_one
  end

  test 'A New User can be Created' do
    assert @user.save
  end
  test 'A User dose not need a Profile' do
    @user.profile = nil
    assert @user.save
  end
  test 'User Needs a Password' do
    @user.password = ''
    @user.password_confirmation = ''
    assert_not @user.save
  end
  test 'User Needs a Username' do
    @user.username = ''
    assert_not @user.save
  end
  test 'User Needs a First Name' do
    @user.first_name = ''
    assert_not @user.save
  end
  test 'User Needs a Last Name' do
    @user.last_name = ''
    assert_not @user.save
  end
  test 'User Needs a User Type' do
    @user.user_type = nil
    assert_not @user.save
  end
  test 'User Needs a Team' do
    @user.team = nil
    assert_not @user.save
  end
  test 'Password and Password Confirmation Match' do
    @user.password = 'password'
    @user.password_confirmation = 'notPassword'
    assert_not @user.save
  end
end

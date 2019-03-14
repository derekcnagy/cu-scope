require 'test_helper'

class UserTypeTest < ActiveSupport::TestCase
  setup do
    @user_type = UserType.new
    @user_type.type_name = 'Admin'
  end
  test 'A User Type can be created' do
    assert @user_type.save
  end
  test 'A User Type needs a Type Name' do
    @user_type.type_name = ''
    assert_not @user_type.save
  end
end

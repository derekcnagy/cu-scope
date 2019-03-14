require 'test_helper'

class UserSettingsHelperTest < ActiveSupport::TestCase
  include UserSettingsHelper

  setup do
    @user = users :viewer
    @password = @user.password_digest
    @not_password = 'notPassword'
    @new_password = 'newPassword'
    @user.password = @password
    @user.save
  end

  test 'The password can be changed' do
    status = update_password(user: @user, old_password: @password,
                             new_password: @new_password, password_confirmation: @new_password)
    assert status
  end
  test 'Update Password requires the old password' do
    status = update_password(user: @user, old_password: @not_password,
                             new_password: @new_password, password_confirmation: @new_password)
    assert_not status
  end
  test 'Update Password requires a new password' do
    status = update_password(user: @user, old_password: @password,
                             new_password: nil, password_confirmation: nil)
    assert status.class.eql? ActiveRecord::RecordInvalid
    assert status.to_s.eql? "Validation failed: Password can't be blank, Password confirmation can't be blank"
  end
  test 'The new password must be confirmed' do
    status = update_password(user: @user, old_password: @password,
                             new_password: @new_password, password_confirmation: nil)

    assert status.class.eql? ActiveRecord::RecordInvalid
    assert status.to_s.eql? "Validation failed: Password confirmation can't be blank"
  end
  test 'The new password must match the confirmation password' do
    status = update_password(user: @user, old_password: @password,
                             new_password: @new_password, password_confirmation: @not_password)
    assert status.class.eql? ActiveRecord::RecordInvalid
    assert status.to_s.eql? "Validation failed: Password confirmation doesn't match Password"
  end
  test 'The User is required' do
    status = update_password(user: nil, old_password: @password,
                             new_password: @new_password, password_confirmation: @new_password)
    assert_not status
  end
end

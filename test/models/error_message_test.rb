require 'test_helper'

class ErrorMessageTest < ActiveSupport::TestCase

  test 'A New Error Message can be Created' do
    error_message = ErrorMessage.new
    error_message.error_message = 'An Error'
    assert error_message.save
  end

  test 'Error Message Needs an Error Message' do
    error_message = ErrorMessage.new
    assert_not error_message.save
  end
end

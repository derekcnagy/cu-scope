module UserSettingsHelper

  def update_password(user:, old_password:, new_password:, password_confirmation:)
    if user && user.authenticate(old_password)
      begin
        user.password = new_password
        user.password_confirmation = password_confirmation
        status = user.save!
        return status
      rescue => error
        return error
      end
    end
  end
end

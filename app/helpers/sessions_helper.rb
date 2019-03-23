module SessionsHelper

  def log_in(user)
    update_session user
  end

  def log_out
    session.delete(:user_id)
    session[:profile] = nil
    session[:team] = 1
  end

  def update_session(user)
    session[:user_id] = user.id
    session[:username] = user.username
    session[:first_name] = user.first_name
    session[:last_name] = user.last_name
    session[:team] = user.team_id
    session[:profile] = user.profile_id
    session[:user_type] = user.user_type_id
  end
end

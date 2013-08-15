module SessionsHelper
  def logged_in?
    !!current_user
  end

  def current_user
    User.find_by_session_token(session[:token])
  end
end

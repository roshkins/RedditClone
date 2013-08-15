module SessionsHelper
  def logged_in?
    !!current_user
  end

  def current_user
    if session[:token]
      User.find_by_session_token(session[:token])
    end
  end
end

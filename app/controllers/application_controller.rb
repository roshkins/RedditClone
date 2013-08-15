class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def destroy_session
    current_user.create_session_token!
    session[:token] = nil
  end

  def make_sure_logged_in
    unless current_user
      redirect_to new_session_url
    end
  end
end

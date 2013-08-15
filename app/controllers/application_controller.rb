class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  def destroy_session
    current_user.create_session_token!
    session[:token] = nil
  end
end

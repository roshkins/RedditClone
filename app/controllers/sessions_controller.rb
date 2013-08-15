class SessionsController < ApplicationController
  def new
    @user = User.new
    unless current_user
      render :new
    else
      redirect_to subs_url
    end
  end

  def destroy
    destroy_session
    redirect_to new_session_url
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.is_authenticated?(params[:user][:password])
      session[:token] = @user.create_session_token!
      redirect_to subs_url
    else
      flash.now[:notice] = "Invalid username or password."
      @user = User.new(params[:user])
      render :new
    end
  end
end

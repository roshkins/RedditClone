class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def destroy
    destroy_session
  end

  def create
    @user = User.find_by_username(params[:user][:username])
    if @user && @user.is_authenticated?(params[:user][:password])
      session[:token] = @user.create_session_token!
      redirect_to user_url(@user)
    else
      flash.now[:notice] = "Invalid username or password."
      @user = User.new(params[:user])
      render :new
    end
  end
end

class UsersController < ApplicationController
  def new
    @user = User.new
    unless current_user
      render :new
    else
      redirect_to links_url
    end
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:token] = @user.create_session_token!
      redirect_to subs_url
    else
      flash.now[:notice] = "There was a problem or two: " +
       @user.errors.full_messages * ", "
      render :new
    end
  end
end

class LinksController < ApplicationController

  def new
    @link = Link.new
    @subs = Sub.all
    render :new
  end

  def create
    @link = current_user.links.new(params[:link])
    @link.sub_ids = params[:subs]

    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:notice] = "Something went wrong with creating a link." +
                           "#{@link.errors.full_messages.join(", ")}"
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
    @subs = Sub.all
    render :edit
  end

  def update
    @link.find(params[:id])
    if @link.submitter == current_user
      if @link.update_attributes(params[:link]) &&
         @link.sub_ids = params[:link][:subs]
       else
         flash.now[:notice] = "Error(S):" +
         " #{@link.errors.full_messages.join(", ")}"
       end
    else
      flash[:notice] = "You shall not pass. You are not the submitter."
      redirect_to link_url(@link)
    end
  end

  def show
    @link = Link.find(params[:id])
    render :show
  end

  def index
    @links = current_user.links.all
  end
end

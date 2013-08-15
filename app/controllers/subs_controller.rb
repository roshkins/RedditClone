class SubsController < ApplicationController
  before_filter :make_sure_logged_in
  def new
    @sub = Sub.new
    @links = [Link.new] * 5
    render :new
  end

  def create
    @sub = Sub.new(params[:sub])
    @sub.moderator_id = current_user.id
    @links = params[:links].map do |_, link|
      next if link.values.all?(&:blank?)
      Link.new(link)
    end.compact

    begin
      ActiveRecord::Base.transaction do
        @sub.save!
        @links.map! { |link| link.id = @sub.id; link.save! }
      end
        flash[:notice] = "Successfully created sub!"
        redirect_to sub_url(@sub)
    rescue
        flash.now[:notice] = "Something went wrong." +
                         " #{@sub.errors.full_messages * " ," if @sub}"  +
                         (@links ? @links.map do |link|
                           next if link.nil?
                           link.errors.full_messages * ", "
                          end * ", " : "")
        render :new
    end
  end

  def index
    @subs = current_user.subs.all
  end

  def edit
    @sub = Sub.find(params[:id])
    @links = @sub.links
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.moderator == current_user
      if @sub.update_attributes(params[:sub])
        redirect_to sub_url(@sub)
      else
        flash.now[:notice] = "Edit failed. Reason(s): " +
                            @sub.errors.full_messages * ", "
        render :edit
      end
    else
      flash[:notice] = "You are not moderator! You cannot edit this page!"
      redirect_to sub_url(@sub)
    end
  end

  def show
  end
end

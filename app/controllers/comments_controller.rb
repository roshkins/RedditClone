class CommentsController < ApplicationController
  before_filter :make_sure_logged_in

  def create
    @comment = Comment.new(params[:comment])
    @comment.link_id = params[:link_id]
    @comment.parent_comment_id = params[:parent_comment_id]
    @comment.author_id = current_user.id
    if @comment.save
      redirect_to link_url(params[:link_id])
    else
      flash.now[:notice] =
      "Hey #{current_user.username}: #{@comment.errors.full_messages * ', '}"
      redirect_to link_url(params[:link_id])
    end
  end
end

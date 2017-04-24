class CommentsController < ApplicationController
  def new
    render :new
  end

  def create
    new_comment_params = comment_params.merge(
      user_id: current_user.id, post_id: params[:post_id],
      parent_comment_id: params[:parent_comment_id]
    )
    comment = Comment.new(new_comment_params)
    if comment.save
      redirect_to post_url(comment.post)
    else
      flash[:errors] = comment.errors.full_messages
      redirect_back fallback_location: subs_url
    end
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    if @comment
      @comments = @comment.child_comments
      render :show
    else
      redirect_to subs_url
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end
end

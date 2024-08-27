class CommentsController < ApplicationController
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.profile = current_user.profile

    if @comment.save
      flash[:notice] = 'Commented successfully!'
    else
      flash[:alert] = 'Unable to comment.'
    end

    respond_to do |format|
      format.html { redirect_back_or_to(root_path) }
      format.turbo_stream
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

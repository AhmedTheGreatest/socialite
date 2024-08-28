class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, only: %i[destroy edit update]
  before_action :authorize_creator, only: %i[destroy edit update]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.profile = current_user.profile

    if @comment.save
      flash.now[:notice] = 'Commented successfully!'
    else
      flash.now[:alert] = 'Unable to comment.'
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to(@post) }
    end
  end

  def destroy
    if @comment&.destroy
      flash.now[:notice] = 'Comment sucessfully deleted!'
    else
      flash.now[:alert] = 'Unable to delete the comment.'
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back_or_to(@post) }
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      flash.now[:notice] = 'Comment updated successfully!'
      render @comment
    else
      flash.now[:alert] = 'Unable to update the comment.'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def authorize_creator
    redirect_back_or_to(@post) unless @comment.profile == current_user.profile
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

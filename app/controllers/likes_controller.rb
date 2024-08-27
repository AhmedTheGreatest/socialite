class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]
  before_action :check_already_liked, only: [:create]

  def create
    @like = @post.likes.new(profile: current_user.profile)

    if @like.save
      flash.now[:notice] = 'Post liked successfully!'
    else
      flash.now[:alert] = 'Unable to like the post.'
    end

    respond_to do |format|
      format.html { redirect_back_or_to(root_path) }
      format.turbo_stream
    end
  end

  def destroy
    if @like&.destroy
      flash.now[:notice] = 'Post unliked successfully!'
    else
      flash.now[:alert] = 'Unable to unlike the post.'
    end

    respond_to do |format|
      format.html { redirect_back_or_to(root_path) }
      format.turbo_stream
    end
  end

  private

  def set_like
    @like = @post.likes.find_by(profile: current_user.profile)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    @post.likes.exists?(profile: current_user.profile)
  end

  def check_already_liked
    if already_liked?
      redirect_back_or_to(root_path, notice: 'You have already liked this post.')
    end
  end
end

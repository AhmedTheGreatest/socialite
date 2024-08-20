class LikesController < ApplicationController
  before_action :set_post
  before_action :set_like, only: [:destroy]
  before_action :check_already_liked, only: [:create]

  def create
    @like = @post.likes.new(profile: current_user.profile)

    unless @like.save
      flash[:alert] = 'Unable to like the post.'
    end

    redirect_back_or_to(root_path)
  end

  def destroy
    if @like&.destroy
      redirect_back_or_to(root_path)
    else
      redirect_back_or_to(root_path, status: :unprocessable_entity, alert: 'Unable to unlike')
    end
  end

  private

  def set_like
    @like = @post.likes.find_by(profile: current_user.profile, post_id: params[:post_id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def already_liked?
    Like.where(profile: current_user.profile, post_id: params[:post_id]).exists?
  end

  def check_already_liked
    if already_liked?
      redirect_back_or_to(root_path, notice: 'Post is already liked')
    end
  end
end

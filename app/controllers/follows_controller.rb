class FollowsController < ApplicationController
  before_action :set_profile, only: [:create, :accept, :destroy, :reject]

  def create
    current_profile.send_follow_request(@profile)
    redirect_back_or_to root_path
  end

  def accept
    current_profile.accept_follow_request(@profile)
    redirect_back_or_to root_path
  end

  def reject
    current_profile.reject_follow_request(@profile)
    redirect_back_or_to root_path
  end

  def destroy
    current_profile.unfollow(@profile)
    redirect_back_or_to root_path
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end
end

class ExploreController < ApplicationController
  def index
    @posts = Post.all
    @profiles = Profile.all
  end
end

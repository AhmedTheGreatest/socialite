class ExploreController < ApplicationController
  def index
    @posts = Post.all
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.order(hotness: :desc).page(params[:page]).per(10)
  end
end

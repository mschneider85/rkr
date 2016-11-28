class PostsController < ApplicationController
  def index
    @posts = Post.includes(:postable).order(hotness: :desc).page(params[:page]).per(10)
  end
end

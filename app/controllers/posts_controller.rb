class PostsController < ApplicationController
  def index
    @posts = Post.search(params[:search]).includes(:postable).order(hotness: :desc).page(params[:page]).per(5)
  end
end

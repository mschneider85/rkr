class TagsController < ApplicationController
  def index
    render json: ActsAsTaggableOn::Tag.named_like(params[:query]).most_used(5).pluck(:name)
  end
end

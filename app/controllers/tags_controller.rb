class TagsController < ApplicationController
  def index
    render json: ActsAsTaggableOn::Tag
      .named_like(params[:query])
      .where.not(name: params[:assigned_tags])
      .most_used(5)
      .pluck(:name)
  end
end

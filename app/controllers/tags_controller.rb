class TagsController < ApplicationController
  def index
    render json: Tag.popular_for(params[:query]).pluck(:name)
  end
end

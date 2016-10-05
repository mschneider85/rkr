class TagsController < ApplicationController
  def index
    @tags = Tag.order(:taggings_count).where('name ILIKE ?', "%#{params[:query]}%").limit(5).pluck(:name)
    render json: @tags
  end
end

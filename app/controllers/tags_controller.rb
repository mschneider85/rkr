class TagsController < ApplicationController
  def index
    @tags = ActsAsTaggableOn::Tag.order(:name).where('name ILIKE ?', "%#{params[:query]}%").limit(5)
    render json: @tags
  end
end

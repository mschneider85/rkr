class LinksController < ApplicationController
  def index
    @links = Link.trending.page(params[:page]).per(10)
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      temp_association = CreateTempAssociation.call(@link, cookies[:temp_association_uuid]) unless user_signed_in?
      notice = 'Link successfully created.' + (' Login or sign up to edit your links.' if temp_association).to_s
      redirect_to links_path, notice: notice
    else
      render :new
    end
  end

  def load_preview
    @preview = Link.parse_preview(params[:url])
  end

  private

  def link_params
    params.require(:link).permit(:author_id, :title, :url, preview: [:url, :title, :favicon, :description, images: [], videos: []])
  end
end

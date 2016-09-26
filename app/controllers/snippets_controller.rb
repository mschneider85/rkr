class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.order_weekly.page(params[:page]).per(10)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      redirect_to snippets_path, notice: 'Snippet successfully created.'
    else
      render :new
    end
  end

  private

  def snippet_params
    params.require(:snippet).permit(:author_id, :session_id, :title, :body, :language)
  end
end

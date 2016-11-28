class SnippetsController < ApplicationController
  def index
    @snippets = Snippet.trending.includes(:votes).page(params[:page]).per(10)
  end

  def new
    @snippet = Snippet.new
  end

  def create
    @snippet = Snippet.new(snippet_params)
    if @snippet.save
      temp_association = CreateTempAssociation.call(@snippet, cookies[:temp_association_uuid]) unless user_signed_in?
      notice = 'Snippet successfully created.' + (' Login or sign up to edit your snippets.' if temp_association).to_s
      redirect_to snippets_path, notice: notice
    else
      render :new
    end
  end

  def language_code
    render plain: Snippet::LANGUAGES.find(params[:name])[:mode]
  end

  private

  def snippet_params
    params.require(:snippet).permit(:author_id, :title, :body, :language, tag_list: [])
  end
end

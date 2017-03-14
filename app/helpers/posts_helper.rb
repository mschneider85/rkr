module PostsHelper
  def highlight_search(string)
    params[:search].present? ? highlight(string, params[:search].split(' ')) : string
  end
end

class Snippet < Post
  enum language: [:vim, :ruby, :yaml, :css, :scss, :sass, :js, :coffee]

  validates :title, :body, presence: true
end

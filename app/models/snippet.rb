class Snippet < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_one :temp_association, as: :temp_associatable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates :title, :body, presence: true

  enum language: [:vim, :ruby, :yaml, :css, :scss, :sass, :js, :coffee]

  scope :order_weekly, -> { order("date_trunc('week', snippets.created_at) desc") }
  scope :trending, -> { find_with_reputation.order_weekly.order('reputation desc') }

  def reputation
    votes.sum(:value)
  end

  def self.find_with_reputation
    select('snippets.*, coalesce(value, 0) as reputation')
      .joins("left join votes on votable_id = snippets.id and votable_type = 'Snippet'")
  end
end

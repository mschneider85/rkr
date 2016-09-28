class Snippet < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_one :temp_association, as: :temp_associatable, dependent: :destroy
  has_many :votes, as: :votable

  validates :title, :body, presence: true

  enum language: [:vim, :ruby, :yaml, :css, :scss, :sass, :js, :coffee]

  scope :order_weekly, -> { order("date_trunc('week', created_at) DESC, title ASC") }

  def reputation
    votes.sum(:value)
  end
end

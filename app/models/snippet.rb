class Snippet < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true
  has_one :temp_association, as: :temp_associatable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  enum language: [:vim, :ruby, :yaml, :css, :scss, :sass, :js, :coffee]
  attr_accessor :reputation
  alias_attribute :reputation, :votes_sum

  validates :title, :body, presence: true

  scope :order_weekly, -> { order("date_trunc('week', created_at) desc") }
  scope :trending, -> { order_weekly.order(votes_sum: :desc, created_at: :desc) }
  scope :hot, -> { order_weekly.order(votes_count: :desc, created_at: :desc) }
  scope :newest_first, -> { order(created_at: :desc) }
end

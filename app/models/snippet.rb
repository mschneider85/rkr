class Snippet < ApplicationRecord
  belongs_to :author, class_name: 'User', optional: true

  validates :title, :body, presence: true

  enum language: [:vim, :ruby, :yaml, :css, :scss, :sass, :js, :coffee]

  scope :order_weekly, -> { order("date_trunc('day', created_at) DESC, title ASC") }
end

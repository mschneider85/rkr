class Tag < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings

  scope :popular_for, -> (query) { where('name ILIKE ?', "%#{query}%").limit(5).order(:taggings_count) }
end

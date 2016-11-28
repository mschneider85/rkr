class Post < ApplicationRecord
  include PgSearch

  mattr_accessor :last_refresh

  self.primary_key = 'searchable_id'

  belongs_to :searchable, polymorphic: true
  belongs_to :author, class_name: 'User', optional: true

  delegate :updated_at, to: :searchable

  def language
    searchable.language if searchable_type == 'Snippet'
  end

  def preview
    searchable.preview if searchable_type == 'Link'
  end

  pg_search_scope :search,
                  against: [
                    [:title, 'A'],
                    [:body, 'B']
                  ],
                  using: {
                    tsearch: { prefix: true, dictionary: 'english', any_word: true, highlight: true }
                  }

  private

  def readonly?
    true
  end
end

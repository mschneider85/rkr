class Post < ApplicationRecord
  include PgSearch

  mattr_accessor :last_refresh

  self.primary_key = 'postable_id'

  belongs_to :postable, polymorphic: true
  belongs_to :author, class_name: 'User', optional: true

  delegate :updated_at, to: :postable

  def self.search(query)
    query.present? ? full_text_search(query).union(Post.where('body ILIKE ?', "%#{query}%")) : all
  end

  def language
    postable.language if postable_type == 'Snippet'
  end

  def preview
    postable.preview if postable_type == 'Link'
  end

  pg_search_scope :full_text_search,
                  against: [
                    [:title, 'A'],
                    [:body, 'B']
                  ],
                  using: {
                    tsearch: { prefix: true, dictionary: 'english', any_word: true, highlight: true, tsvector_column: %w(tsv_title tsv_body) }
                  }

  private

  def readonly?
    true
  end
end

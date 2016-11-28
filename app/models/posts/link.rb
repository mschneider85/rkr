class Link < ApplicationRecord
  include Postable
  acts_as_taggable

  store_accessor :preview

  has_one :post, foreign_key: 'searchable_id'

  validates :title, :url, presence: true
  validates :url, url: { allow_blank: true }

  before_validation { self[:url] = Link.sanitize_url(url) }

  def self.parse_preview(url)
    url = sanitize_url(url)
    begin
      preview = LinkThumbnailer.generate(url)
      preview.favicon = preview.url + preview.favicon unless valid_attribute?(:url, preview.favicon)
      preview.videos.reject! { |video| video.embed_code.nil? }
      if (preview.images.size + preview.videos.size).zero?
        preview.images << preview.favicon
      end
      preview
    rescue LinkThumbnailer::Exceptions
      false
    end
  end.to_json

  def self.sanitize_url(url)
    url.strip!
    url.blank? || url.start_with?('http://', 'https://') ? url : url.prepend('http://')
  end
end

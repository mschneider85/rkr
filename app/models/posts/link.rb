class Link < Post
  store_accessor :preview

  validates :title, :url, presence: true
  validates :url, url: { allow_blank: true }

  before_validation { self[:url] = Link.sanitize_url(url) }

  def self.parse_preview(url)
    url = Link.sanitize_url(url)
    begin
      preview = LinkThumbnailer.generate(url)
      preview.favicon = preview.url + preview.favicon unless Link.valid_attribute?(:url, preview.favicon)
      preview.videos.reject! { |video| video.embed_code.nil? }
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

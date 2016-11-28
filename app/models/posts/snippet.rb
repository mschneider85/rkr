class Snippet < ApplicationRecord
  include Postable
  acts_as_taggable

  enum language: [:ruby, :yaml, :css, :scss, :sass, :javascript, :coffeescript, :html, :haml, :slim, :erb, :markdown, :shell, :plain]

  validates :title, :body, presence: true

  def mode
    LANGUAGES.find(language)[:mode]
  end

  class LANGUAGES
    class << self
      def all
        HashWithIndifferentAccess.new(YAML.load(File.read(File.expand_path('../languages.yml', __FILE__))))
      end

      def find(term)
        all[term]
      end

      def where(**args)
        collection = all
        args.each do |arg|
          query_key, query_value = arg
          collection.select! { |_key, hash| hash[query_key] == query_value }
        end
        collection
      end
    end
  end
end

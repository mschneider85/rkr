class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value.blank? && options[:allow_blank] || open(value, allow_redirections: :safe).status == %w(200 OK)
  rescue
    record.errors.add(attribute, (options[:message] || :invalid))
  end
end

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.human_enum_name(enum_name, enum_value)
    I18n.t("activerecord.attributes.#{model_name.i18n_key}.#{enum_name.to_s.pluralize}.#{enum_value}")
  end

  def self.valid_attribute?(attr, value)
    mock = new(attr => value)
    mock.valid? ? true : !mock.errors.key?(attr)
  end
end

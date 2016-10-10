class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.valid_attribute?(attr, value)
    mock = new(attr => value)
    mock.valid? ? true : !mock.errors.key?(attr)
  end
end

class TempAssociation < ApplicationRecord
  belongs_to :temp_associatable, polymorphic: true

  validates :uuid, presence: true
end

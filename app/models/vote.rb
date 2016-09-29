class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :votable, polymorphic: true

  attr_accessor :can_update_vote

  validates :voter_id, uniqueness: { scope: [:votable_type, :votable_id] }, unless: :can_update_vote
  validates :value, inclusion: { in: [1, -1] }, uniqueness: { scope: [:voter_id, :votable_type, :votable_id] }
  validate :ensure_not_author

  private

  def ensure_not_author
    errors.add :voter_id, 'is the author' if votable.author_id == voter_id
  end
end

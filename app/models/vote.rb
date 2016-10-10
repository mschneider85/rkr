class Vote < ApplicationRecord
  belongs_to :voter, class_name: 'User'
  belongs_to :votable, polymorphic: true

  enum value: { down: -1, up: 1 }
  attr_accessor :update_vote
  VOTABLE_TYPES = {
    'Snippet' => Snippet,
    'Link' => Link
  }.freeze

  validates :voter_id, uniqueness: { scope: [:votable_type, :votable_id] }, unless: :update_vote
  validates :value, inclusion: { in: values.keys }, uniqueness: { scope: [:voter_id, :votable_type, :votable_id] }, unless: :update_vote
  validate :ensure_not_author

  after_commit do
    RefreshCacheColumnsJob.new.perform(votable)
  end

  private

  def ensure_not_author
    errors.add :voter_id, 'is the author' if votable.author_id == voter_id
  end
end

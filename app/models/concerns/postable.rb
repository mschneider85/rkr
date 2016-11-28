module Postable
  extend ActiveSupport::Concern

  included do
    belongs_to :author, class_name: 'User', optional: true
    has_one :temp_association, as: :temp_associatable, dependent: :destroy
    has_many :votes, as: :votable, dependent: :destroy

    alias_attribute :reputation, :votes_sum

    scope :order_weekly, -> { order("date_trunc('week', created_at) desc") }
    scope :trending, -> { order_weekly.order(votes_sum: :desc, created_at: :desc) }
    scope :hot, -> { order_weekly.order(votes_count: :desc, created_at: :desc) }
    scope :newest_first, -> { order(created_at: :desc) }

    after_commit do
      RefreshMaterializedView.call(:posts)
    end
  end
end

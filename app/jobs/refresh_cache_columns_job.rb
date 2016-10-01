class RefreshCacheColumnsJob < ApplicationJob
  def perform(object = nil)
    if object
      update_cache_columns(object)
    else
      update_all_votables_cache_columns
    end
  end

  private

  def update_cache_columns(object)
    object.update_columns(votes_sum: object.votes.sum(:value), votes_count: object.votes.count)
  end

  def update_all_votables_cache_columns
    Vote.pluck(:votable_type).uniq.each do |votable_type|
      klass = votable_type.constantize
      klass.includes(:votes).each do |object|
        update_cache_columns(object)
      end
    end
  end
end

class VotesController < ApplicationController
  def create
    @votable = Vote::VOTABLE_TYPES.fetch(params[:vote][:votable_type]).find(params[:vote][:votable_id])
    if EvaluateVote.call(votable: @votable, voter: current_user, value: params[:vote][:direction])
      @votable.reputation = @votable.votes.sum(:value)
    end
  end
end

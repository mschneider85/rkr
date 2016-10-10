class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action do
    cookies.permanent[:temp_association_uuid] ||= SecureRandom.uuid
  end

  def voted?(votable, direction)
    voter = current_user || User.new
    Vote.exists?(voter: voter, votable: votable, value: direction)
  end
  helper_method :voted?

  def can_vote?(votable, direction)
    votable?(votable) &&
      user_signed_in? &&
      Vote.new(value: direction, votable: votable, update_vote: true, voter: current_user).valid?
  end
  helper_method :can_vote?

  private

  def votable?(object)
    object.class.reflect_on_association(:votes).type.present?
  end
end

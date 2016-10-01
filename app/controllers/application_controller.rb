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
end

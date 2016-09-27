class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action do
    cookies.permanent[:temp_association_uuid] ||= SecureRandom.uuid
  end
end

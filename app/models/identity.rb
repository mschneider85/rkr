class Identity < ApplicationRecord
  belongs_to :user

  after_create :push!

  def push!
    update_columns(last_sign_in_at: Time.current)
  end

  def self.from_omniauth(auth)
    identity = Identity.where(provider: auth.provider, uid: auth.uid).take
    if identity
      identity.push!
      identity.user
    else
      registered_user = User.where(email: auth.info.email).take
      if registered_user
        CreateOmniauthIdentity.call(registered_user, auth)
      else
        new_user = User.create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.confirmed_at = Time.current
        end
        CreateOmniauthIdentity.call(new_user, auth)
      end
    end
  end
end

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
        registered_user.create_identity_for(auth)
        registered_user
      else
        user = User.create do |user|
          user.email = auth.info.email
          user.password = Devise.friendly_token[0, 20]
          user.confirmed_at = Time.current
        end
        user.create_identity_for(auth)
        user
      end
    end
  end
end

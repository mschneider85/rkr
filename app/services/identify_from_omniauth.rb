class IdentifyFromOmniauth
  def self.call(auth)
    identity = Identity.find_by(provider: auth.provider, uid: auth.uid)
    if identity
      identity.push!
      identity.user
    else
      registered_user = User.find_by(email: auth.info.email)
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

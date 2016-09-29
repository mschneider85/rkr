class CreateOmniauthIdentity
  def self.call(user, auth)
    user.identities.create do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      case auth.provider
      when 'github'
        identity.avatar = auth.info.image + '&s=32' if auth.info.image
      when 'bitbucket'
        identity.avatar = auth.info.avatar if auth.info.avatar
      end
    end
    user
  end
end

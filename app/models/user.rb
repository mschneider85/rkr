class User < ApplicationRecord
  default_scope { order(:created_at) }

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, omniauth_providers: [:bitbucket, :github]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.confirmed_at = Time.current
      case auth.provider
      when 'github'
        user.provider_avatar = auth.info.image + '&s=32' if auth.info.image
      when 'bitbucket'
        user.provider_avatar = auth.info.avatar if auth.info.avatar
      end
    end
  end
end

class User < ApplicationRecord
  default_scope { order(:created_at) }

  has_many :identities, dependent: :destroy

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, omniauth_providers: [:bitbucket, :github]

  def avatar
    recent_identity&.avatar || gravatar
  end

  def create_identity_for(auth)
    identities.create do |identity|
      identity.provider = auth.provider
      identity.uid = auth.uid
      case auth.provider
      when 'github'
        identity.avatar = auth.info.image + '&s=32' if auth.info.image
      when 'bitbucket'
        identity.avatar = auth.info.avatar if auth.info.avatar
      end
    end
  end

  private

  def recent_identity
    @recent_identity ||= identities.order(last_sign_in_at: :desc).first
  end

  def gravatar
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://gravatar.com/avatar/#{gravatar_id}.png?s=32&d=retro"
  end
end

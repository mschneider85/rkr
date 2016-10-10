class User < ApplicationRecord
  default_scope { order(:created_at) }

  has_many :identities, dependent: :destroy
  has_many :snippets, foreign_key: :author_id
  has_many :links, foreign_key: :author_id
  has_many :votes, foreign_key: :voter_id

  # Add more model_votes like this
  has_many :snippet_votes, through: :snippets, source: :votes
  has_many :link_votes, through: :links, source: :votes

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :omniauthable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, omniauth_providers: [:bitbucket, :github]

  def avatar
    recent_identity&.avatar || gravatar
  end

  def reputation
    snippet_votes.sum(:value) + link_votes.sum(:value)
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

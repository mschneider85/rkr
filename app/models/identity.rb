class Identity < ApplicationRecord
  belongs_to :user

  after_create :push!

  def push!
    update_columns(last_sign_in_at: Time.current)
  end
end

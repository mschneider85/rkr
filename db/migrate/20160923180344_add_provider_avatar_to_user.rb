class AddProviderAvatarToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider_avatar, :string
  end
end

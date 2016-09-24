class CreateIdentities < ActiveRecord::Migration[5.0]
  def self.up
    create_table :identities, id: :uuid do |t|
      t.belongs_to :user, type: :uuid, null: false, index: true
      t.string :provider
      t.string :uid
      t.string :avatar
      t.datetime :last_sign_in_at

      t.timestamps
    end

    change_table :users do |t|
      t.remove :provider
      t.remove :uid
      t.remove :provider_avatar
    end
  end

  def self.down
    drop_table :identities

    change_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :provider_avatar
    end
  end
end

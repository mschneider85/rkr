class CreateLink < ActiveRecord::Migration[5.0]
  def change
    create_table :links, id: :uuid do |t|
      t.belongs_to :author, type: :uuid, index: true
      t.string :title
      t.string :url
      t.integer :votes_count, null: false, default: 0, index: true
      t.integer :votes_sum, null: false, default: 0, index: true

      t.timestamps
    end
  end
end

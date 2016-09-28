class CreateVote < ActiveRecord::Migration[5.0]
  def change
    create_table :votes, id: :uuid do |t|
      t.belongs_to :votable, polymorphic: true, type: :uuid, index: { unique: true }
      t.belongs_to :voter, type: :uuid, index: true
      t.integer :value, null: false, default: 0

      t.timestamps
    end
  end
end

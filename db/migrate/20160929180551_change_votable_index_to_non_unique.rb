class ChangeVotableIndexToNonUnique < ActiveRecord::Migration[5.0]
  def self.up
    remove_index :votes, [:votable_type, :votable_id]
    add_index :votes, [:votable_type, :votable_id]
  end

  def self.down
    remove_index :votes, [:votable_type, :votable_id]
    add_index :votes, [:votable_type, :votable_id], unique: true
  end
end

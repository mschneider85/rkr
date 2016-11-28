class AddIndexesToPost < ActiveRecord::Migration[5.0]
  def change
    add_index :posts, :author_id
    add_index :posts, :votes_sum
    add_index :posts, :votes_count
    add_index :posts, :created_at
  end
end

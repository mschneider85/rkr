class AddIndexToPost < ActiveRecord::Migration[5.0]
  def up
    add_index :posts, :hotness
  end

  def down
    execute 'drop index index_posts_on_hotness;'
  end
end

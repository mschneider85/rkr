class AddIndexIdToPost < ActiveRecord::Migration[5.0]
  def up
    add_index :posts, :id, unique: true
  end

  def down
    execute 'drop index index_posts_on_id;'
  end
end

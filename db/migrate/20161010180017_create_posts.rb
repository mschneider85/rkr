class CreatePosts < ActiveRecord::Migration
  def change
    create_view :posts, materialized: true
  end
end

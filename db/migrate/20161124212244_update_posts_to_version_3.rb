class UpdatePostsToVersion3 < ActiveRecord::Migration
  def change
    update_view :posts, materialized: true, version: 3, revert_to_version: 2
  end
end

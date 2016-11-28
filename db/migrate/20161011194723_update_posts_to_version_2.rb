class UpdatePostsToVersion2 < ActiveRecord::Migration
  def change
    update_view :posts, materialized: true, version: 2, revert_to_version: 1
  end
end

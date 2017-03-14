class AddTitleAndBodyIndexesToPost < ActiveRecord::Migration[5.0]
  def up
    execute 'CREATE INDEX index_posts_on_title_tgrm ON posts USING GIN(title gin_trgm_ops);'
    execute 'CREATE INDEX index_posts_on_body_tgrm ON posts USING GIN(body gin_trgm_ops);'
  end

  def down
    execute 'drop index index_posts_on_title_tgrm;'
    execute 'drop index index_posts_on_body_tgrm;'
  end
end

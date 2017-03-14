class AddTsvIndexesToPost < ActiveRecord::Migration[5.0]
  def up
    execute 'create index index_posts_tsv_title on posts using gin(tsv_title);'
    execute 'create index index_posts_tsv_body on posts using gin(tsv_body);'
  end

  def down
    execute 'drop index index_posts_tsv_title;'
    execute 'drop index index_posts_tsv_body;'
  end
end

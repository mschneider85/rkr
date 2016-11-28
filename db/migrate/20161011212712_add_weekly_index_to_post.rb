class AddWeeklyIndexToPost < ActiveRecord::Migration[5.0]
  def up
    execute "create index posts_creation_week_index on posts (date_trunc('week', created_at));"
  end

  def down
    execute "drop index posts_creation_week_index;"
  end
end

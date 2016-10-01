class AddCacheColumnsToSnippet < ActiveRecord::Migration[5.0]
  def change
    add_column :snippets, :votes_sum, :integer, null: false, default: 0
    add_column :snippets, :votes_count, :integer, null: false, default: 0

    add_index :snippets, :votes_sum
    add_index :snippets, :votes_count
  end
end

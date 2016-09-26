class CreateSnippets < ActiveRecord::Migration[5.0]
  def change
    create_table :snippets, id: :uuid do |t|
      t.belongs_to :author, type: :uuid, index: true
      t.string :session_id, index: true
      t.string :title
      t.text :body
      t.integer :language, null: false, default: 0

      t.timestamps
    end
  end
end

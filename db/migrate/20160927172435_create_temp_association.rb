class CreateTempAssociation < ActiveRecord::Migration[5.0]
  def change
    create_table :temp_associations, id: :uuid do |t|
      t.belongs_to :temp_associatable, polymorphic: true, type: :uuid, index: { unique: true, name: 'index_polymorphic_temp_associations' }
      t.uuid :uuid, index: true

      t.timestamps
    end
    remove_index :snippets, column: :session_id
    remove_column :snippets, :session_id, :string
  end
end

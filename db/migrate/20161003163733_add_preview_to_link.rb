class AddPreviewToLink < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :preview, :json
  end
end

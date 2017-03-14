class EnableFuzzystrmatch < ActiveRecord::Migration[5.0]
  def up
    enable_extension 'pg_trgm'
  end

  def down
    disable_extension 'pg_trgm'
  end
end

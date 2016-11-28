class RefreshMaterializedView
  mattr_accessor :current_thread_token

  def self.call(table_name)
    Thread.new do
      token = SecureRandom.hex
      self.current_thread_token = token
      sleep 4
      Scenic.database.refresh_materialized_view(table_name.to_sym, concurrently: false) if current_thread_token == token
      Post.last_refresh = Time.current
    end
  end
end

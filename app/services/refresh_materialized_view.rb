class RefreshMaterializedView
  mattr_accessor :current_thread_token

  class << self
    def call(table_name)
      Thread.new do
        token = SecureRandom.hex
        mutex.synchronize do
          self.current_thread_token = token
        end
        sleep 4
        Scenic.database.refresh_materialized_view(table_name.to_sym, concurrently: true) if current_thread_token == token
        Post.last_refresh = Time.current
      end
    end

    private

    def mutex
      @mutex ||= Mutex.new
    end
  end
end

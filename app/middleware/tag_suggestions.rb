class TagSuggestions
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/tags'
      request_params = Rack::Request.new(env).params
      terms = query_tags(request_params['query'], request_params['assigned_tags'])
      [200, { 'Content-Type' => 'application/json' }, [terms.to_json]]
    else
      @app.call(env)
    end
  end

  private

  def query_tags(query, assigned_tags)
    ActsAsTaggableOn::Tag
      .named_like(query)
      .where.not(name: assigned_tags)
      .most_used(5)
      .pluck(:name)
  end
end

class TagSuggestions
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/tags'
      request = Rack::Request.new(env)
      terms = query_tags(request.params['query'], request.params['assigned_tags'])
      [200, { 'Content-Type' => 'application/json' }, [terms.to_json]]
    else
      @app.call(env)
    end
  end

  def query_tags(query, assigned_tags)
    ActsAsTaggableOn::Tag
      .named_like(query)
      .where.not(name: assigned_tags)
      .most_used(5)
      .pluck(:name)
  end
end

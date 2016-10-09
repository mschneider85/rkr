class TagSuggestions
  def initialize(app)
    @app = app
  end

  def call(env)
    if env['PATH_INFO'] == '/tags'
      request = Rack::Request.new(env)
      terms = ActsAsTaggableOn::Tag
              .named_like(request.params['query'])
              .where.not(name: request.params['assigned_tags'])
              .most_used(5)
              .pluck(:name)
      [200, { 'Content-Type' => 'application/json' }, [terms.to_json]]
    else
      @app.call(env)
    end
  end
end

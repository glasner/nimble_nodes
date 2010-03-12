module NimbleNodes
  class Middleware
    def initialize(app)
      @app = app
    end


    def call(env)
      NimbleNodes.monitor(env)
      # now, execute the request using our Rails app
      response = @app.call(env)
    end
  end
end
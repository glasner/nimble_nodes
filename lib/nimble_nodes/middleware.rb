module NimbleNodes
  class Middleware
    def initialize(app)
      @app = app
    end


    def call(env)
      @report = NimbleNodes::Report.new(env)
      @report.post if @report.post?
      # now, execute the request using our Rails app
      response = @app.call(env)
    end
  end
end
module NimbleNodes
      
  class Report
    
    def initialize(env)
      @dynos_in_use = env['HTTP_X_HEROKU_DYNOS_IN_USE'].to_i
      @request_queue_depth = env['HTTP_X_HEROKU_QUEUE_DEPTH'].to_i
    end
    
    def post
      params = {
        :dynos_in_use => @dynos_in_use,
        :request_queue_size => @request_queue_depth }
      NimbleNodes::Server.post('/dynos/reports.json', params)
    end
    
    # returns true if report needs to be posted to server
    def post?
      return true
      dynos_maxed_out? or queue_depth_too_long? or queue_depth_too_short? or idle_dynos?
    end
    
    # returns true if app is using all available dynos
    def dynos_maxed_out?
      return false if @dynos_in_use.nil?
      @dynos_in_use >= NimbleNodes::Dynos.max
    end
    
    # returns true if queue depth is over max
    def queue_depth_too_long?
      return false if @request_queue_depth.nil?
      @request_queue_depth > NimbleNodes::Dynos.max_request_queue
    end
    
    def queue_depth_too_short?
      return false if @request_queue_depth.nil?
      @request_queue_depth < NimbleNodes::Dynos.min_request_queue
    end
    
    # returns true if app isn't using all of it's dynos
    def idle_dynos?
      return false if @dynos_in_use.nil?
      @dynos_in_use < NimbleNodes::Dynos.size
    end

  end
  
end
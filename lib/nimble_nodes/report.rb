module NimbleNodes
      
  class Report
    def initializer
      @dynos_in_use = ENV['HTTP_X_HEROKU_DYNOS_IN_USE']
      @request_queue_depth = ENV['HTTP_X_HEROKU_QUEUE_DEPTH']
    end
    
    def post
      params = {
        :dynos_in_use => @dynos_in_use,
        :request_queue_size => @request_queue_depth }
      NimbleNodes::Server.post('/dynos/reports.json', params)
    end
    
    def post?
      return true
      dynos_maxed_out? or queue_depth_too_long?
    end
    
    def dynos_maxed_out?
      return false if @dynos_in_use.nil?
      @dynos_in_use >= Dynos.max
    end
  
    def queue_depth_too_long?
      return false if @request_queue_depth.nil?
      @request_queue_depth > Dynos.max_request_queue
    end

  end
  
end
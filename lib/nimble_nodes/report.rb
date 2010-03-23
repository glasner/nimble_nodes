module NimbleNodes
      
  class Report
    
    
    def self.path
      "/#{ENV['NN_APP_NAME']}/dynos/reports.json"
    end
    
    def initialize(env)
      @dynos_in_use = env['HTTP_X_HEROKU_DYNOS_IN_USE'].to_i
      @request_queue_depth = env['HTTP_X_HEROKU_QUEUE_DEPTH'].to_i
    end
    
    def post
      params = {
        :dynos_in_use => @dynos_in_use,
        :request_queue_size => @request_queue_depth }
      NimbleNodes::Server.post(self.class.path, params)
    end
    
    def post?
      return false unless NimbleNodes.installed?
      return true
      return false if NimbleNodes.paused?
      dynos_maxed_out? or queue_depth_too_long? or unused_dynos?
    end
    
    def dynos_maxed_out?
      return false if @dynos_in_use.nil?
      @dynos_in_use >= Dynos.max
    end
  
    def queue_depth_too_long?
      return false if @request_queue_depth.nil?
      @request_queue_depth > Dynos.max_request_queue
    end
    
    def unused_dynos?
      return false if @dynos_in_use.nil?
      @dynos_in_use < Dynos.size
    end

  end
  
end
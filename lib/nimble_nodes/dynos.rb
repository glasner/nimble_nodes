module NimbleNodes
  
  module Dynos
    
    def self.max
      ENV['NN_DYNO_POOL_MAX']
    end
    
    def self.max_request_queue
      ENV['NN_DYNOS_REQUEST_QUEUE_MAX']
    end
    
  end
  
end
module NimbleNodes
  
  module Dynos
    
    def self.size
      ENV['NN_DYNOS_POOL_SIZE']
    end
    
    def self.max
      ENV['NN_DYNOS_POOL_MAX']
    end
    
    def self.max_request_queue
      ENV['NN_DYNOS_REQUEST_QUEUE_MAX']
    end
    
  end
  
end
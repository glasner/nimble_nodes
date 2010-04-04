module NimbleNodes
  
  module Workers
    
    def self.active?
      ENV.has_key?('NN_WORKERS_POOL_ACTIVE')
    end
    
    def self.size
      ENV['NN_WORKERS_POOL_SIZE']
    end
    
    def self.min
      ENV['NN_WORKERS_POOL_MIN']
    end
    
    def self.max
      ENV['NN_WORKERS_POOL_MAX']
    end
    
    def self.min
      ENV['NN_WORKERS_POOL_MIN']
    end
    
    def self.min_job_queue
      ENV['NN_WORKERS_JOB_QUEUE_MIN']
    end
    
    def self.max_job_queue
      ENV['NN_WORKERS_JOB_QUEUE_MAX']
    end
    
  end
  
end
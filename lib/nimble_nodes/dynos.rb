module NimbleNodes
  
  module Dynos
    
    #= Settings
    
    # shortcut for accessing NimbleNodes.settings[:dynos_pool][key]
    def self.[](key)
      NimbleNodes::Dynos.settings[key]
    end
    
    def self.settings
      hash = NimbleNodes::Settings['dynos_pool']
      hash.nil? ? {} : hash
    end
    
    def self.size
      NimbleNodes::Dynos['size']
    end
    
    def self.min
      NimbleNodes::Dynos['min']
    end
    
    def self.max
      NimbleNodes::Dynos['max']
    end
    
    def self.request_queue
      hash = NimbleNodes::Dynos.settings['request_queue']
      hash.nil? ? {} : hash
    end
    
    def self.min_request_queue
      NimbleNodes::Dynos.request_queue['min']
    end
    
    def self.max_request_queue
      NimbleNodes::Dynos.request_queue['max']
    end
    
    #= Status Inspector
    
    def self.paused?
      not NimbleNodes::Dynos['paused_at'].nil? 
    end
    
    #= Monitoring
    
    def self.monitor?
      NimbleNodes.active? and !NimbleNodes::Dynos.paused?
    end
    
    
    # pass over the hash containing Rack env variables
    # a Report will be created and posted if neccessary 
    def self.monitor(env)
      begin
        report = NimbleNodes::Report.new(env)
        report.post if report.post?
      rescue
        # rescues any possible errors to ensure app performace isn't affected
      end
    end
    
  end
  
end
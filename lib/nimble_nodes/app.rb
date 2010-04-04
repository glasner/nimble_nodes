module NimbleNodes
  
  module App
    
    #= Rails
    
    def self.rails?
      defined?(RAILS_GEM_VERSION) ? true : false
    end
    
    def self.rails_version
      RAILS_GEM_VERSION.slice(0..2).to_f
    end
    
    #== Check Rails version  
    # returns true if gem is loaded in a pre 2.3 version of rails
    def self.use_rails_filter?
      NimbleNodes::App.rails? and NimbleNodes::App.rails_version < 2.3
    end  
      
    # set through Heroku API when app is created
    def self.name
      ENV['NIMBLE_NODES_APP_NAME']
    end
    
    # set through Heroku API when app is created at server
    def self.token
      ENV['NIMBLE_NODES_APP_TOKEN']
    end
    
    # returns true if app has been setup at server correctly
    def self.token?
      not NimbleNodes::App.token.nil?
    end
    
    # path at server for calling app resource and subresources
    def self.path(subpath='/')
      name = NimbleNodes::App.name
      return nil if name.nil?
      '/' + name + subpath
    end
    
    # returns path to platform specific report implementation 
    def self.reporter
      path = NimbleNodes::App.use_rails_filter? ? '/rails/filter' : '/middleware'
      NimbleNodes.lib_path(path)
    end
    
  end
  
end
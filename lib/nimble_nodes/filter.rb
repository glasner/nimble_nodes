module NimbleNodes
  
  module Filter
    
    # Use as a before_filter
    def monitor_heroku_app
      NimbleNodes.monitor(request.env)
    end
    
    
  end
  
end

ActionController::Base.send(:include, NimbleNodes::Filter)
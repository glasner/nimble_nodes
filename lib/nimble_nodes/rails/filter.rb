module NimbleNodes
  module Rails
    module Filter

      # Use as a before_filter
      def monitor_heroku_app
        NimbleNodes::Dynos.monitor(request.env) if NimbleNodes::Dynos.monitor?
      end


    end
  end
  
  
end

ActionController::Base.send(:include, NimbleNodes::Rails::Filter)
module NimbleNodes
  
  class Settings
    
    #= Setting accessor
    #= allows NimbleNodes::Settings to be treated as a hash
    # shortcut for accessing NimbleNodes.settings cache
    def self.[](key)
      cache[key]
    end
    
    private
    
    #= Cache
    # settings are fetched once from server and cached in global constant
    
    # returns hash of settings from cache or fetched from nimblenodes.com
    def self.cache
      return CACHE if cache? and fresh_cache?
      const_set('CACHE',NimbleNodes::Settings.fetch_from_server) 
    end    
    
    #== Fetch from server
    
    # returns hash from parsed server response
    def self.fetch_from_server
      response = NimbleNodes::Server.get("/settings.json")
      return {} if response.nil?
      JSON[response].merge('fetched_at' => Time.now)
    end
    
    #== Cache Inspectors
    
    # returns true if local settings have been set
    def self.cache?
      defined?(NimbleNodes::Settings::CACHE) and !NimbleNodes::Settings::CACHE.nil? and !NimbleNodes::Settings::CACHE.empty?
    end 
    
    def self.fresh_cache?
      fetched_at = CACHE['fetched_at']
      return false if fetched_at.nil?
      age = Time.now.to_i - fetched_at.to_i
      five_minutes = 300
      age > five_minutes
    end
    
    
    
  end
  
end
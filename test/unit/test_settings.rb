require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class Test::Unit::TestCase
  
  
  
  def self.should_not_raise_any_errors_when_fetching_from_server
    should "not raise any errors when fetching from server" do
      assert_nothing_raised { @module.fetch_from_server }
    end
  end
  
  def self.should_not_raise_any_errors_on_unknown_keys
    should "not raise errors on any unknown keys" do
      assert_nothing_raised { @module.cache['bogus-key'] }
    end
  end
  
  
end

class TestSettings < Test::Unit::TestCase
  
  context "Settings" do
    
    setup { 
      @module = NimbleNodes::Settings 
      @module.send(:remove_const,'CACHE') if defined?(@module::CACHE)
    }
    
    context "App is installed at NimbleNodes.com" do
      setup do
        setup_installed_app
      end
      
      context "server responds with JSON" do
        
        setup {
          @json = '{"paused_at":null,"dynos_pool":{"size":1,"paused_at":null,"max":1,"request_queue":{"max":5,"min":0},"min":1}}'
          @parsed = JSON[@json]
          NimbleNodes::Server.expects(:get).returns(@json)
        }        
        
        # should "only fetch from server once" do
        #   @module.expects(:fetch_from_server).once
        #   @module['paused_at']
        #   @module['dynos_pool']
        # end
        
        should "save parsed parsed response in cache" do
          cached = @module.cache
          cached.delete('fetched_at')
          assert_equal @parsed, cached
        end
        
        should "add fetched_at to server response" do
          assert_not_nil @module['fetched_at']
        end        
        
        should_not_raise_any_errors_on_unknown_keys
        
        should_not_raise_any_errors_when_fetching_from_server        
        
      end
      
      context "server responds with error" do
        setup { NimbleNodes::Server.expects(:get).once.returns(nil) }
        should_not_raise_any_errors_on_unknown_keys
        should_not_raise_any_errors_when_fetching_from_server
      end
      
    end
    
    context "App is *not* installed at NimbleNodes.com" do
      
      setup {
        setup_invalid_app
        NimbleNodes::Server.expects(:get).returns(nil)
      }
      
      should_not_raise_any_errors_on_unknown_keys
      should_not_raise_any_errors_when_fetching_from_server
      
    end
    
    
  end
  
end

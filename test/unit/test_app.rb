require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class TestApp < Test::Unit::TestCase
  
  context "An App" do
    
    setup { @module = NimbleNodes::App }
    
    context "on Rails" do
      
      setup { @module.stubs(:rails?).returns(true) }
      
      context "2.3 or later" do
        setup { @module.stubs(:rails_version).returns(2.3) }
        
        should "not use rails before_filter" do
          assert(!@module.use_rails_filter?)
        end
        
        should "return NimbleNodes::Middleware as reporter" do
          assert_equal 'middleware', @module.reporter.split('/').last
        end
        
      end
      
      context "prior to 2.3" do
        setup { NimbleNodes::App.stubs(:rails_version).returns(2.2) }
        
        should "use rails before_filter" do
          assert(@module.use_rails_filter?)
        end
        
        should "return NimbleNodes::Filter as reporter" do
          assert_equal 'filter', @module.reporter.split('/').last
        end
        
      end
      
      
    end
    
    context "off Rails" do
      
      should "return false for rails?" do
        # we're not in Rails so this works
        assert_equal false, @module.rails?
      end
      
      should "return NimbleNodes::Middleware as reporter" do
        assert_equal 'middleware', @module.reporter.split('/').last
      end
      
    end
  
  
    context "installed at NimbleNodes" do
    
      setup { 
        ENV['NIMBLE_NODES_APP_NAME']  = 'nimble-nodes-test'
        ENV['NIMBLE_NODES_APP_TOKEN'] = 'test'
      }
      
      should "return name from ENV" do
        assert_equal ENV['NIMBLE_NODES_APP_NAME'], @module.name
      end
      
      should "return token from ENV" do
        assert_equal ENV['NIMBLE_NODES_APP_TOKEN'], @module.token
      end
      
      should "return true for token?" do
        assert @module.token?
      end
      
      should "return relative path at NN server" do
        assert_equal '/nimble-nodes-test/', @module.path
      end
      
      should "return relative path to app resource for given path" do
        assert_equal '/nimble-nodes-test/dynos', @module.path('/dynos')
      end
      

    end
    
    context "not installed at NimbleNodes" do
      
      setup { 
        ENV['NIMBLE_NODES_APP_NAME']  = nil
        ENV['NIMBLE_NODES_APP_TOKEN'] = nil
      }
      
      should "return false for token?" do
        assert_equal false, @module.token?
      end
      
    end
    
    
  end
  
end

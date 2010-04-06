require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class Test::Unit::TestCase
  
  def self.should_not_raise_anything_on_get
    
    should "catch all errors from creating path" do
      NimbleNodes::App.expects(:path).raises(ArgumentError)
      assert_nothing_raised { @module.get('/settings.json') }
    end
    
    should "catch all errors from concatenating URL" do
      NimbleNodes::Server.expects(:url).raises(ArgumentError)
      assert_nothing_raised { @module.get('/settings.json') }
    end
    
    should "catch all errors from parsing URI" do
      NimbleNodes::Server.stubs(:uri_with_token).raises(ArgumentError)
      assert_nothing_raised { @module.get('/settings.json') }
    end
    
    should "catch all errors from Net::HTTP" do
      Net::HTTP.stubs(:start).raises(Net::HTTPError)
      assert_nothing_raised { @module.get('/settings.json') }
    end
  end
  
  def self.should_not_raise_anything_on_post
    
    should "catch all errors from creating path" do
      NimbleNodes::App.expects(:path).raises(ArgumentError)
      assert_nothing_raised { @module.post('/',{}) }
    end
    
    should "catch all errors from concatenating URL" do
      NimbleNodes::Server.expects(:url).raises(ArgumentError)
      assert_nothing_raised { @module.post('/',{}) }
    end
    
    should "catch all errors from parsing URI" do
      NimbleNodes::Server.stubs(:uri_with_token).raises(ArgumentError)
      assert_nothing_raised { @module.post('/',{}) }
    end
    
    should "catch all errors from Net::HTTP" do
      Net::HTTP.stubs(:start).raises(Net::HTTPError)
      assert_nothing_raised { @module.post('/',{}) }
    end
  end
  
end

class TestServer < Test::Unit::TestCase
  
  context "Server" do
    
    setup { 
      @module = NimbleNodes::Server
    }
    
    context "App is installed at NimbleNodes.com" do
      
      setup { setup_installed_app }
      
      should_not_raise_anything_on_get
      should_not_raise_anything_on_post
    end
    
    context "App isn't installed at NimbleNodes.com" do
      setup { setup_invalid_app }
      
      should_not_raise_anything_on_get
      should_not_raise_anything_on_post
    end
     
    
    
  end
  
end

require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class Test::Unit::TestCase
  
  def self.should_not_raise_anything_when_monitored
    should "not raise any exceptions when sent :monitored?" do
      assert_nothing_raised { @module.monitor? }
      NimbleNodes::Server.stubs(:post).returns(nil)
      assert_nothing_raised { @module.monitor({}) }
    end
  end
  
  def self.should_not_be_monitored
    should "not be monitored" do
      assert_equal false, @module.monitor?
    end
  end
  
  
end


class TestDynos < Test::Unit::TestCase
  
  context "Dynos" do
      
    setup { 
      @module = NimbleNodes::Dynos 
    }
    
    context "App setup at NimbleNodes" do
      
      setup { 
        NimbleNodes::App.stubs({
          :name => 'nimble-nodes-test',
          :token => 'token'
        })
         @module.stubs(:settings).returns({
            'paused_at' => nil,
            'min' => 1,
            'max' => 2
          })
      }
  
      context "and App not paused" do
        setup { NimbleNodes.stubs(:paused?).returns(false)  }
        
        should "be monitored" do
          assert @module.monitor?
        end
        
        should_not_raise_anything_when_monitored
        
        context "and Dynos paused" do
          setup {
            @module.stubs(:settings).returns({
              'paused_at' => Time.now,
              'min' => 1,
              'max' => 2
            })
          }
          
          should "be paused" do
            assert @module.paused?
          end
          
          should_not_be_monitored
          should_not_raise_anything_when_monitored
          
        end
        
        
      end
      
       context "and App paused" do
        setup { NimbleNodes.stubs(:paused?).returns(true)  }
        should_not_be_monitored
        should_not_raise_anything_when_monitored

      end
      
  
    end
     
    context "App *not* setup at NimbleNodes.com" do
 
      should_not_be_monitored

      should_not_raise_anything_when_monitored

 
    end
    
    
  end
  
end

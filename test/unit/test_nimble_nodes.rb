require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class TestNimbleNodes < Test::Unit::TestCase
  
  
  context "NimbleNodes module" do
    setup { @module = NimbleNodes }
    
    context "in a Rails app" do
      
      setup { NimbleNodes::App.stubs(:rails?).returns(true) }

      context "pre 2.3" do
        setup { NimbleNodes::App.stubs(:rails_version).returns(2.2) }

        should "use NimbleNodes::Filter as reporter" do
          assert_equal 'filter', @module.reporter.split('/').last
        end

      end 
      
      context "2.3 or later" do
        setup { NimbleNodes::App.stubs(:rails_version).returns(2.3) }

        should "use NimbleNodes::Middleware as reporter" do
          assert_equal 'middleware', @module.reporter.split('/').last
        end

      end   

    end
    
    context "in a non-Rails app" do
      setup { NimbleNodes::App.stubs(:rails?).returns(false) }
      
      should "use NimbleNodes::Middleware" do
        assert_equal 'middleware8', @module.reporter.split('/').last
      end
      
    end

    context "App installed at NimbleNodes" do

      setup { 
        NimbleNodes::App.stubs({
          :name => 'nimble-nodes-test',
          :token => 'token'
        })
      } 

      context "not paused" do

        setup {
          @module.stubs(:paused?).returns(false)
        }

        should "be active" do
          assert @module.active?
        end
      end

      context "paused" do

        setup {
          @module.stubs(:paused?).returns(true)
        }

        should "be not active" do
          assert(!@module.active?)
        end
      end

    end
    
    
  end
  

  
end

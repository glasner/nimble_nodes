require File.expand_path(File.dirname(__FILE__)) + '/../helper'

class TestNimbleNodes < Test::Unit::TestCase
  
  
  context "NimbleNodes module" do
    setup { @module = NimbleNodes }
    

    context "App installed at NimbleNodes" do

      setup { 
        setup_installed_app
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

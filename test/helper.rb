require 'rubygems'
require 'test/unit'

require 'shoulda'
require 'mocha'
require 'fakeweb'

require File.expand_path(File.dirname(__FILE__)) + '/../lib/nimble_nodes'

class Test::Unit::TestCase
  
  def setup_installed_app
    NimbleNodes::App.stubs({
      :name => "nimble-nodes-test", 
      :token => 'test'
    })
  end
  
  def setup_invalid_app
    NimbleNodes::App.stubs({
      :name => nil, 
      :token => nil
    })
  end
  
end

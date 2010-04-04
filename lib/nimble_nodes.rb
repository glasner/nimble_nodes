require 'json'

module NimbleNodes
  
  #= Check Rails version  
  # returns true if gem is loaded in a pre 2.3 version of rails
  def self.legacy?
    defined?(RAILS_GEM_VERSION) and RAILS_GEM_VERSION.slice(0..2).to_f < 2.3
  end  
  
  #= App status inspectors  
  def self.active?
    NimbleNodes::App.token? and !NimbleNodes.paused?
  end
  
  def self.paused?
    not NimbleNodes::Settings[:paused_at].nil?
  end
  
  
  
  def self.lib_path(path='')
    File.dirname(__FILE__) + '/nimble_nodes' + path
  end
  
end

files = %w(app settings dynos workers report server)
files.each { |file| require NimbleNodes.lib_path('/' + file) }

require NimbleNodes::App.reporter




  


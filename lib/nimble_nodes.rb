module NimbleNodes
  
  # returns array of files
  def self.files
    files = %w(dynos report server)
    files.push NimbleNodes.legacy? ? 'filter' : 'middleware'
    files
  end
  
  # returns true if gem is loaded in a pre 2.3 version of rails
  def self.legacy?
    defined?(RAILS_GEM_VERSION) and RAILS_GEM_VERSION.slice(0..2).to_f < 2.3
  end
  
  #= Monitoring
  # pass over the hash containing Rack env variables
  # a Report will be created and posted if neccessary 
  def self.monitor(env)
    report = NimbleNodes::Report.new(env)
    report.post if report.post?
  end
  
end

NimbleNodes.files.each { |file| require File.dirname(__FILE__) + "/nimble_nodes/#{file}" }




  


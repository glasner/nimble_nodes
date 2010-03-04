module NimbleNodes
end


current_path = File.dirname(__FILE__)

%w(dynos report server middleware).each do |file|
  require "#{current_path}/nimble_nodes/#{file}"
end


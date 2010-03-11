require 'net/http'

module NimbleNodes
  
  class Server
    
    def self.post(path,args)    
      url = URI.parse(url_to(path))
      request = Net::HTTP::Post.new(url.path)
      request.set_form_data({:token => ENV['NN_APP_TOKEN'], :json => args.to_json, :created_at => Time.now })
      response = Net::HTTP.start(url.host, url.port) {|http| http.request(request)}
    end
    
    def self.url_to(path)
      'http://' + ENV['NN_SERVER_DOMAIN'] + path
      # 'http://nimblenodes.com' + path
    end
    
  end
  
end
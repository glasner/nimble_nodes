require 'net/http'

module NimbleNodes
  
  class Server
    
    #= HTTP Requests 
    # GETs and POSTs both add App.token to request automatically
    
    def self.get(path)   
      begin
        path = NimbleNodes::App.path(path)
        uri = NimbleNodes::Server.uri_with_token(path)     
        path = uri.route_from(NimbleNodes::Server.url[0..-2]).to_s
        request = Net::HTTP::Get.new(path)
        return Net::HTTP.start(uri.host, uri.port) {|http| http.request(request)}.body
      rescue
        return nil
      end
    end    


    def self.post(path,params)    
      begin
        path = NimbleNodes::App.path(path)
        uri = uri(path)
        request = Net::HTTP::Post.new(uri.path)
        request.set_form_data({:token => NimbleNodes::App.token, :json => params.to_json, :created_at => Time.now })
        return Net::HTTP.start(uri.host, uri.port) {|http| http.request(request)}
      rescue
        return nil
      end
    end
    
  
    #= Domain & URLs
    
    # set ENV variable in development to override production domain
    def self.domain
      ENV['NIMBLE_NODES_DOMAIN'].nil? ? 'nimblenodes.com' : ENV['NIMBLE_NODES_DOMAIN']
    end
    
    # returns string for url to given path at server
    def self.url(path='/')
      'http://' + domain + path
    end
    
    # returns parsed URI for given path at server
    def self.uri(path)
      URI.parse(url(path))
    end
    
    # returns parsed URI with App.token in query
    def self.uri_with_token(path)
      uri = uri(path)
      query = (uri.query || '').split('&')
      query.push("token=#{NimbleNodes::App.token}")
      uri.query = query.join('&')
      uri
    end
    
    
    
  end
  
end
require 'rest-client'
require 'json'
class Request
    def connect(url)
        response = RestClient.get(url)
        posts = JSON.parse(response.body)
    end
end
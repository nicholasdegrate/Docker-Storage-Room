require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require_relative '../../config/.api'

class RequestApi

    def self.request_api(subject)
        url = URI("https://free-nba.p.rapidapi.com/#{subject}?page=0&per_page=150")


        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true
        
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        request = Net::HTTP::Get.new(url)

        request["x-rapidapi-key"] = "#{$api_key}"
        request["x-rapidapi-host"] = "#{$api_url}"
        
        response = http.request(request)
        parsed = JSON.parse(response.read_body)
        
        parsed['data'].map { |hash| hash}
    end

end
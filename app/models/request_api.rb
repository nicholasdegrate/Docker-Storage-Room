require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class RequestApi(subject)
    
    url = URI("https://free-nba.p.rapidapi.com/#{subject}page=0&per_page=25")
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
    request = Net::HTTP::Get.new(url)
    request["x-rapidapi-key"] = 'afe348c621mshafd9fd57eb463bdp10d323jsn9bc4b04fb556'
    request["x-rapidapi-host"] = 'api-basketball.p.rapidapi.com'
    
    binding.pry
    response = http.request(request)
    parsed = JSON.parse(response.read_body)

    parsed["name"]
end
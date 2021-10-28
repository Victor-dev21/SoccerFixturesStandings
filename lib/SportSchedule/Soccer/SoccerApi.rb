require 'uri'
require 'net/http'
require 'openssl'

url = URI("https://api-football-v1.p.rapidapi.com/v3/timezone")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
request["x-rapidapi-key"] = 'ee4e753b26msh01dbf7b67482dd6p1b28cbjsn99b2d5d984eb'

response = http.request(request)
puts response.read_body

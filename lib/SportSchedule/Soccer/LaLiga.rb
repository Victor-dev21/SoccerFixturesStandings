require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'

url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?date=2021-10-31&league=140&season=2021")
path = ENV['SOCCER_API']
api_key = File.open(path).read

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

request = Net::HTTP::Get.new(url)
request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
request["x-rapidapi-key"] = api_key

response = http.request(request)
response = JSON.parse(response.body.gsub("=>", ":").gsub(":nil,", ":null,"))
puts JSON.pretty_generate(response)
puts
#puts JSON.pretty_generate(response['response'][2]['teams']['home']['name'])
#puts JSON.pretty_generate(response['response'][2]['teams']['away']['name'])
puts JSON.pretty_generate(response['response'])

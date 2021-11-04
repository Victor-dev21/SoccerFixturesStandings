class BasketballApi

	def self.establish_connection(url)
		path = ENV['SPORT_API']
		api_key = File.open(path).read
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
		request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
		request["x-rapidapi-key"] = api_key
		response = http.request(request)
		response = JSON.parse(response.body.gsub("=>", ":").gsub(":nil,", ":null,"))
	end

end

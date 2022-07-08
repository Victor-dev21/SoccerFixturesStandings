class ApiConnect
  def self.api_connection(url)
		path = ENV['SOCCER_API']
    api_key = File.open(path).read.strip
    #comment out the above the two lines and uncomment the one below
    #path = ENV['YOUR_API_KEY_HERE']
		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE
		request = Net::HTTP::Get.new(url)
    if (self.name.include?("Soccer"))
		   request["x-rapidapi-host"] = 'api-football-v1.p.rapidapi.com'
    elsif(self.name.include?("Baseball"))
      request["x-rapidapi-host"] = 'api-baseball.p.rapidapi.com'
    end
		request["x-rapidapi-key"] = api_key
		response = http.request(request)
		response = JSON.parse(response.body.gsub("=>", ":").gsub(":nil,", ":null,"))
	end
end

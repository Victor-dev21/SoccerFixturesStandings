require_relative 'SoccerScraper'
require_relative 'LaLigaParser'
class LaLiga

	@@hash = Hash.new.compare_by_identity

	def self.hash
		@@hash
	end

	def self.parse_matchday_date
	hash = Hash.new.compare_by_identity
	SoccerScraper.scrape_date_from_matchday.each do |date|
		date = date.split(" ")
				hash[date[0]] = date[1].to_i
		end
		hash
	end

	def self.create_hash_from_collection
		collection = SoccerScraper.scrape_date_from_matchday
		collection.each do |date|
			LaLigaParser.parse_date_array(date,self.hash)
		end
		self.hash
	end
	#start from the current date

end
LaLiga.create_hash_from_collection.each do |key,value|
		puts "#{key} : #{value}"
end

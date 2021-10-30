require 'nokogiri'
require 'open-uri'
require 'date'
class SoccerScraper

	URL = "https://en.as.com/resultados/futbol/primera/calendario/" unless const_defined?(:URL)
def self.scrape_matchday_tables
	hash = Hash.new
	doc = Nokogiri::HTML(URI.open(URL))
	matchday = doc.css("div.row")# gets table in which date is being held
end
#creates an array of strings of dates
# ex. ["25 - 27 Sep","Dec 10"] so on until the
# last calendar date of the season
def self.scrape_date_from_matchday
	array_of_dates = []
	matchday = self.scrape_matchday_tables
	array_of_matchdays = matchday.css("div.col-md-6.col-sm-6.col-xs-12")
	array_of_matchdays.each do |match|
		array_of_dates << match.css("span.fecha-evento").text.strip
	end
	array_of_dates.delete_at(0)
	array_of_dates
end

def parse_string_and_create_date_object(str)
	#"27 - 29 Aug"
	temp_array = str.split(" ")
	month_abbreviated = str.chars.last(3).join
	month_number = Date.parse(month_abbreviated)
end

def self.create_date_object_from_collection
	array_of_dates = self.scrape_date_from_matchday
	hash = Hash.new.compare_by_identity
	date_objects = []
	array_of_dates.each do |str|
		date = str.split(" ")
				hash[date.last] = date[0].to_i
	end
hash
end

def self.date_as_keys
	hash = Hash.new.compare_by_identity
	self.scrape_date_from_matchday.each do |date|
		temp_array = date.split(" ")
		#if(parse_date_array(temp_array)>=Date.today)
		if(temp_array.length > 2)
			first_date = parse_date_array(temp_array)
			hash[first_date] = []
			hash[first_date.next] = []
			hash[first_date.next.next] = []
		else
			date = parse_date_array(temp_array)
			hash[date] = []
		end
	#end

	end
hash
end

def self.parse_date_array(input)
		current_year = Date.today.year # 2021
		first_date_of_matchday_number = input.first.to_i
		month = Date.parse(input.last).month
		Date.new(current_year,month,first_date_of_matchday_number)
	end

	def self.scrape_matches
		match_day = self.scrape_matchday_tables
		array_of_matchdays = match_day.css("div.col-md-6.col-sm-6.col-xs-12")
		array_of_matchdays.each do |match|

		end
	end



end

#puts Date.new(2021,12,10) < Date.new(2021,11,10)
SoccerScraper.date_as_keys.each do |key,value|
	puts "#{key}: #{value}"
end
#p SoccerScraper.scrape_matches

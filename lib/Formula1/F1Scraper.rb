require 'nokogiri'
require 'open-uri'

class F1Scraper
	URL = "https://www.espn.com/f1/schedule" unless const_defined?(:URL)
	def self.scrape_schedule_table
		doc = Nokogiri::HTML(URI.open(URL))
		table = doc.css("tbody.Table__TBODY")#gets table in which date is being held
	end
	#
	def self.scrape_dates_from_schedule
			table = self.scrape_schedule_table
			row =  table.css("tr.Table__TR.Table__TR--sm.Table__even")
			dates = row.css("td.date__col.Table__TD")# get column info (we want to get the date)
			race_weekends = dates.css("span.date__innerCell") # store dates in an array
	end
	# returns a an array of dates
	# with EACH race weekend stored into one cell
	# ex. array[0] = Mar 26 - 28 and so on
	def self.scrape_race_weekends
			race_dates_table = self.scrape_dates_from_schedule
			all_race_dates = []
			race_dates_table.each do |weekend|
				all_race_dates << weekend.text
			end
			all_race_dates
	end
	#gets the name of the grand prixs
	def self.scrape_grand_prix_names
		table = self.scrape_schedule_table
		row = table.css("tr.Table__TR.Table__TR--sm.Table__even")
		races = row.css("td.race__col.Table__TD")
		grand_prixs = races.css("a.AnchorLink")
	end

	def self.grand_prixs
		array = []

		F1Scraper.scrape_grand_prix_names.each do |race|
			array << race.text
		end
		array
	end
end
#p F1Scraper.scrape_grand_prix_names
#F1Scraper.grand_prixs_with_dates.each do |race|
#	puts "#{race}"
#end
#p F1Scraper.grand_prixs.size

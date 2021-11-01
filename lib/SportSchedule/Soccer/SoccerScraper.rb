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
	# ex. ["25 - 27 Sep","Dec 10"]and so on until the
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

	def self.scrape_matches
		match_day = self.scrape_matchday_tables
		match = ""
		all_matches = []
		array_of_matchdays = match_day.css("div.col-md-6.col-sm-6.col-xs-12")
		matches = array_of_matchdays.css("table.tabla-datos")
		matches.each do |row| # loops through each matchday
			all_rows_of_a_matchday = row.css("tbody")
			all_rows_of_a_matchday.each do |r|
				node = Nokogiri::XML::DocumentFragment.parse(r.to_s).at_css("tr")#gets the id of the first match
				current_match_id = node['id']
				local_id = parse_id(current_match_id)[0]
				away_id = parse_id(current_match_id)[1]

				local = "#{row.css("td.col-equipo-local.#{local_id}").text.strip}"
				away = "#{row.css("td.col-equipo-visitante.#{away_id}").text.strip}"
				puts "#{local} vs #{away}"
				end

		end
		all_matches
	end


	def self.parse_id(id)
		temp = id.reverse.split('_', 2).collect(&:reverse).reverse
		local_id = temp[0]
		away_id = temp[1].prepend("sel_")
		[local_id,away_id]
	end

	def self.create_matches_from_collection(array)
		local_id = parse_id(current_match_id)[0]
		away_id = parse_id(current_match_id)[1]

		local = "#{row.css("td.col-equipo-local span.nombre-equipo.#{local_id}").text.strip}"
		away = "#{row.css("td.col-equipo-visitante span.nombre-equipo.#{away_id}").text.strip}"
	end

end
#"td.col-equipo-local.sel_121"
p SoccerScraper.scrape_matches
p SoccerScraper.parse_id("sel_17_172")
p Date.new(2021,10,10).to_s

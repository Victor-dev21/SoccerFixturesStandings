require_relative 'SoccerScraper'
class LaLigaParser

	def self.parse_date_array(date,hash)
		date = date.split(" ")
		parsed_array_of_dates = []
		if(date.length == 5)
			parsed_array_of_dates = parse_dates_that_are_in_between_months(date)
			link_events_with_date(parsed_array_of_dates,hash)
		elsif(date.length == 4)
			parsed_array_of_dates = parse_date_in_same_month(date)
			link_events_with_date(parsed_array_of_dates,hash)
		else
			parses_date(date,hash)
		end
	end

		# creates two date objects from example:[30,Oct,-,01,Nov]
	def self.parse_dates_that_are_in_between_months(dates)
		current_year = Date.today.year
		month_of_starting_date = Date.parse(dates[1]).month
		first_date_of_matchday_number = dates.first.to_i
		starting_date = Date.new(current_year,month_of_starting_date,first_date_of_matchday_number)
		month_of_ending_date = Date.parse(dates.last).month
		last_date_of_matchday_number = dates[3].to_i
		ending_date = Date.new(current_year,month_of_ending_date,last_date_of_matchday_number)
		[starting_date,ending_date]
	end

			# creates two date objects from example:[27,-,29,Aug]
	def self.parse_date_in_same_month(dates)
		current_year = Date.today.year
		month = Date.parse(dates.last).month
		first_date_of_matchday_number = dates.first.to_i
		starting_date = Date.new(current_year,month,first_date_of_matchday_number)
		month = Date.parse(dates.last).month
		last_date_of_matchday_number = dates[2].to_i
		ending_date = Date.new(current_year,month,last_date_of_matchday_number)
		[starting_date,ending_date]
	end

	def self.parses_date(date,hash)
		current_year = Date.today.year
		month = Date.parse(date.last).month
		first_date_of_matchday_number = date.first.to_i
		date = Date.new(current_year,month,first_date_of_matchday_number)
		hash[date] = []
	end
			# creates two date objects from example:[27,Aug]
	def self.link_events_with_date(array,hash)
		starting_date = array[0]
		ending_date = array[1]
		while(starting_date <= ending_date) do
		hash[starting_date] = []
		starting_date = starting_date.next
		end
	end
end

require_relative './Soccer/Fixture'
require_relative './Formula1/F1'
class Cli
	def run
		Fixture.create_matches_from_collection
		FormulaOne.create_event_from_collection
		display_options
	end


	def display_options
		puts"Get upcoming fixtures for your favorite sport(s), favorite team(s), or your favorite soccer league(s)."
		puts"Available sports: Soccer, Formula 1"
		puts"Please select a number:  "
		puts"1. Get upcoming Soccer fixtures by league"
		puts"2. Get the upcoming fixture for your favorite team"
		puts"3. Get fixtures by date for all available sports"
		puts"4. Get the next upcoming F1 race weekend dates"

		input = gets.strip
		if(input == "1")
			option_1
		elsif(input == "2")
			option_2
		elsif(input == "3")
			option_3
		end
	end

	def option_1
		puts "Select a league"
		puts "1. La Liga"
		puts "2. Premier League"
		puts "3. Serie A"
		puts "4. Bundesliga"
		input = gets.strip
		if(input == "1")
			puts"These are the latest fixtures La Liga fixtures for the upcoming week."
			Fixture.display_latest_fixtures(SoccerApi::LaLiga)
		elsif(input == "2")
			puts"These are the latest fixtures La Liga fixtures for the upcoming week."
			Fixture.display_latest_fixtures(SoccerApi::Premier_League)
		elsif(input == "3")
			puts"These are the latest fixtures La Liga fixtures for the upcoming week."
			Fixture.display_latest_fixtures(SoccerApi::SerieA)
		elsif(input =="4")
			Fixture.display_latest_fixtures(SoccerApi::Bundesliga)
		end
	end

	def option_2
		puts "Enter the name of your favorit team"
		input = gets.strip
		Fixture.search_upcoming_fixtures_by_team(input)
	end


	def option_3
		puts "Enter a date in the form of mm-dd-yyyy"
		input = gets.strip
		date = parse_date(input)
		FormulaOne.find_event_by_date(date)
		Fixture.search_fixtures_by_date(date.to_s)
	end

	def parse_date(input)
		input = input.split("-")
		date = input[1].to_i
		month = input[0].to_i
		year = input[2].to_i
		Date.new(year,month,date)
	end

end
Cli.new.run

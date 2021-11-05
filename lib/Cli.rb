require_relative './Soccer/Fixture'
class Cli
	def run
		Fixture.create_matches_from_collection
		display_options
	end


	def display_options
		puts"Get upcoming fixtures for your favorite soccer team(s), or your favorite soccer league(s)."
		puts"Please select a number:  "
		puts"1. Get upcoming Soccer fixtures by league"
		puts"2. Get the upcoming fixtures for your favorite team"
		puts"3. Get fixtures by date for all leagues"
		puts"4. Get standings for a league"
		puts"5. Top goal scorers for all leagues"
		puts"Enter the letter q to quit."


		input = gets.strip
		if input != "q"
			#while(input != "q")
				if(input == "1")
					option_1
				elsif(input == "2")
					option_2
				elsif(input == "3")
					option_3
				elsif(input == "4")
					option_4
				end
			#end
		end
	end

	def option_1
		puts "Select a number for a league"
		puts "1. La Liga"
		puts "2. Premier League"
		puts "3. Serie A"
		puts "4. Bundesliga"
		puts "5. Ligue 1"
		puts "6. MLS"
		puts "7. Liga Mx"
		puts "Or enter q to quit"
		input = gets.strip
		if(input != "q")
			#while(input != "q")
					index = input.strip.to_i
					Fixture.display_latest_fixtures(SoccerApi.top_leagues_id[index-1])
					option_1

			end
		end



	def option_2
		puts "Enter the name of your favorite team or press q to quit"
		input = gets.strip
		if(input != "q")
			Fixture.search_upcoming_fixtures_by_team(input)
			option_2
		end
	end


	def option_3
		puts "Enter a date in the form of mm-dd-yyyy"
		input = gets.strip
		date = parse_date(input)
		Fixture.search_fixtures_by_date(date)
	end

	def option_4
		puts "Select a number for a league"
		puts "1. La Liga"
		puts "2. Premier League"
		puts "3. Serie A"
		puts "4. Bundesliga"
		puts "5. Ligue 1"
		puts "6. MLS"
		puts "7. Liga Mx"
		puts "Or enter q to quit"
		input = gets.strip
		if(input != "q")
			index = input.strip.to_i
			index = SoccerApi.top_leagues_id[index - 1]
			SoccerApi.standings_by_league(index)
			option_4
		end
	end

	def parse_date(input)
		input = input.split("-")
		date = input[1].to_i
		month = input[0].to_i
		year = input[2].to_i
		Date.new(year,month,date).to_s
	end

end
Cli.new.run

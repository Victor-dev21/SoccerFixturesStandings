require_relative './Fixture'
require_relative './LeagueStats'
require_relative './WorldCup/UserInterface'
require_relative '../DateParser'
class SoccerUI
  def soccer_options
    Fixture.create_matches_from_collection
		puts"Get upcoming fixtures or standings for your favorite soccer team(s), or your favorite soccer league(s)."
		puts"Please select a number:  "
		puts"1. Get upcoming fixtures by league"
		puts"2. Get the upcoming fixtures for your favorite team"
		puts"3. Get fixtures by date for all leagues"
		puts"4. Get the standings for your favorite league"
    puts "5. Get top goal scorers"
    puts "6. World Cup"
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
				elsif(input == "5")
					option_5
        elsif(input == "6")
          option_6
				end
		end
	end

	def option_1
		league_options_display
		input = gets.strip
		if(input != "q")
			#while(input != "q")
			id = input.strip.to_i
			Fixture.display_current_round_fixtures(id)
			option_1
		end
	end

	def option_2
		puts "Enter the name of your favorite team or enter q to quit"
		input = gets.strip
		if(input != "q")
			Fixture.search_upcoming_fixtures_by_team(input)
			option_2
		end
	end

	def option_3
		puts "Enter a date in the form of mm-dd-yyyy or enter q to quit"
		input = gets.strip
		if(input != "q")
			date = DateParser.parse_input_date(input).to_s
			Fixture.search_fixtures_by_date(date)
			option_3
		end
	end

	def option_4
		league_options_display
		input = gets.strip
		if(input != "q")
			id = input.strip.to_i
			LeagueStats.standings_by_league_id(id)
			option_4
		end
	end

  def option_5
    league_options_display
    LeagueStats.create_players
		input = gets.strip
		if(input != "q")
			id = input.strip.to_i
			LeagueStats.top_scorers_by_league_id(id)
			option_5
		end
  end

  def option_6
    UserInterface.options
  end

	def league_options_display
		puts "Enter the league ID"
    SoccerApi.leagues.each do |key,value|
      puts "#{key}: #{value}"
    end
	end
end

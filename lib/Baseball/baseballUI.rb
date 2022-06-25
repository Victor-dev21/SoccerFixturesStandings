require_relative './Teams.rb'
require_relative './BaseballApi.rb'
class BaseballUI
  def options
    BaseballApi.fetch_all_divisions
    puts "Enter a number"
    puts "1. Current standings by divisions"
    puts "2. Display upcoming games for your favorite team"
    input = gets.strip
    if(input == "1")
      Teams.display_teams
    elsif(input =="2")
      option_2
      #puts BaseballApi.fetch_games_by_team(input)
    end
  end
  def option_1
    Teams.display_teams
    option_1
  end

  def option_2
    puts "Enter the team's name"
    input = gets.strip
    BaseballUI.display_team_games(input)
    option_2
  end
  def self.display_team_games(name)
    games = BaseballApi.fetch_games_by_team(name)
    games.each do |game|
      #try game['response'][0] maybe try bottome again
      if(!game['response'][0].nil?)
      puts "#{game['response'][0]['teams']['away']['name']} @ #{game['response'][0]['teams']['home']['name']} #{DateParser.user_friendly_date(DateParser.parse_date(game['response'][0]['date'].split("T")[0]))}"
    end
    end
  end
end

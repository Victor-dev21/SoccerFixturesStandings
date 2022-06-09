require_relative './Teams.rb'
require_relative './BaseballApi.rb'
class BaseballUI
  def options
    puts "Enter a number"
    puts "1. Current standings by divisions"
    puts "2. Upcoming fixtures by team"
    input = gets.strip
    if(input == "1")
      BaseballApi.all_divisions
      Teams.display_teams
    end
  end



  def display_standings

  end
end

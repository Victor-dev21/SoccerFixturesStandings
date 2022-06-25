require_relative '../Fixture'
require_relative '../LeagueStats'

class UserInterface

  def self.options
    puts "1. Fixtures"
    puts "2. Group standings"
    input = gets.strip
    if input == "1"
      option_1
    elsif input == "2"
      option_2
    end
  end

  def self.option_1
    puts "Fixtures"
    Fixture.display_current_round_fixtures(1)
  end

  def self.option_2
    puts "Standings"
    LeagueStats.standings_by_league_id(1)
  end
end

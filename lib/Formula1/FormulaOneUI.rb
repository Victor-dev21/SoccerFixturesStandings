require_relative './Formula1ApiCalls'
class FormulaOneUI
  def options
    puts "Select a number to see a statistic"
    puts "1. Driver standings"
    puts "2. Upcoming scheduled races"
    input = gets.strip
    if(input == "1")
      format_standings(standings)
    elsif(input == "2")
      format_races()
    end
  end
  def show_standings
     Formula1ApiCalls.currentDriverStandings
  end

  def show_upcoming_races
    Formula1ApiCalls.upcoming_race_weekends
  end

  def format_standings(hash)
    standings = show_standings()
  puts "Current standings"
    standings.each do |key,value|
      puts "#{key}. #{value[0].ljust(40,"......")} Wins:#{value[1]} Points:#{value[2]}"
    end
  end

  def format_races
    races = show_upcoming_races()
    races.each do |key,weekend|
      puts key
      weekend.each do |race|
        race.each do |key,value|
        puts "#{key.to_s.ljust(20,".")} #{value}"
        end
      end
    end
  end
end

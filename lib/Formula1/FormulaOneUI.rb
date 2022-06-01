require_relative './Formula1ApiCalls'
require_relative "../DateParser"
class FormulaOneUI
  def options
    puts "Next Race"
  #  Formula1ApiCalls.next_race
    puts "Select a number to see a statistic"
    puts "1. Driver standings"
    puts "2. Upcoming scheduled races"
    puts "3. Constrcutors championship standings"
    input = gets.strip
    if(input == "1")
      format_standings()
    elsif(input == "2")
      format_races()
    elsif(input == "3")
      format_constructors()
    end
  end
  def show_standings
     Formula1ApiCalls.currentDriverStandings
  end

  def show_upcoming_races
    Formula1ApiCalls.upcoming_race_weekends
  end

  def show_constructors_standings
    #Formula1ApiCalls.
  end

  def format_standings()
    standings = show_standings()
    puts "Current standings"
    standings.each do |key,value|
      puts "#{key}. #{value[0].ljust(40,"......")} Wins:#{value[1]} Points:#{value[2]}"
    end
  end

  def format_event_time(hash)
    fp1,date = hash.first
    time = hash[hash.keys[1]]
    "#{fp1.to_s.ljust(20,".")} #{DateParser.user_friendly_date(date)}: #{DateParser.parse_time(time)}"
  end

  def format_constructors()
    constructors = Formula1ApiCalls.constructors
    constructors.each do |key,team|
      puts "#{key}.#{team[:name].ljust(20)} Points:#{team[:points]} Wins:#{team[:wins]} "
    end
  end



  def format_races
    races = show_upcoming_races()
    races.each do |grandPrix,weekend|
      puts grandPrix
      weekend.each do |race|
        puts format_event_time(race)
        end
      end
      puts "\n"
    end
  end

require_relative './Formula1Api'
require_relative './FormatData'
require_relative "../DateParser"
class FormulaOneUI
  def options
    puts "Next Race"
    Formula1Api.parse_race_weekends
    FormatData.print_next_race
    Formula1Api.currentDriverStandings
    puts "Enter a number to view more"
    puts "1. Current driver standings"
    puts "2. Upcoming scheduled races"
    puts "3. Constructors championship standings"
    puts "4. Search races by month"
    input = gets.strip
    if(input == "1")
      FormatData.format_standings
    elsif(input == "2")
      FormatData.format_races
    elsif(input == "3")
      FormatData.format_constructors
    elsif(input == "4")
      puts "Type in a month"
      input = gets.strip
      FormatData.search_race_weekends_by_month(input)
    end
  end
end

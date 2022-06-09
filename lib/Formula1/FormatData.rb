require_relative './Formula1Api'
require 'date'
require 'pry'
class FormatData

  def self.format_standings
    puts "Current standings"
    Formula1Api.standings.each do |key,driver|
      position = key
      name = driver[0]
      wins = driver[1]
      points = driver[2]
      puts "#{position}. #{name.ljust(40,"......")} Wins:#{wins} Points:#{points}"
    end
  end

  def self.format_constructors
    Formula1Api.constructors_standings.each do |key,team|
      puts "#{key}.#{team[:name].ljust(20)} Points:#{team[:points]} Wins:#{team[:wins]} "
    end
  end

  def self.format_event_time(event)
    eventName,date = event.first
    time = event[:time]
    "#{eventName.to_s.ljust(20,".")} #{DateParser.user_friendly_date(date)}: #{DateParser.parse_time(time)}"
  end

  def self.print_next_race
    raceName,dates = Formula1Api.schedule.first
    puts raceName
    dates.each do |weekend|
      puts format_event_time(weekend)
    end
  end

  def self.sort_event_dates(weekend)
    weekend.sort{|a,b| a.values.first <=> b.values.first}
  end

  def self.format_races
    Formula1Api.schedule.each do |grandPrixName,weekend|
    puts grandPrixName
      self.sort_event_dates(weekend).each do |race|
        puts format_event_time(race)
      end
    end
    puts "\n"
  end

  def self.search_race_weekends_by_month(month)
    Formula1Api.schedule.each do |grandPrixName,weekend|
      print_name = true
      self.sort_event_dates(weekend).each do |event|
        if Date::MONTHNAMES[event.values.first.month] == month.strip
          puts "#{grandPrixName}" if print_name
          puts format_event_time(event)
          print_name = nil
        end
      end
    end
  end
end

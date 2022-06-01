require 'open-uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
require_relative "../DateParser"
class Formula1ApiCalls

  @@standings = Hash.new
  @@current_round = 0
  @@schedule = Hash.new

  def self.standings
    @@standings
  end
  def self.current_round
    @@current_round
  end

  def self.schedule
    @@schedule
  end

  def self.currentDriverStandings
    response = URI.open("http://ergast.com/api/f1/2022/driverStandings.json").string
    json = JSON.parse(response)
    @@current_round = json["MRData"]["StandingsTable"]["StandingsLists"][0]["round"]
    json["MRData"]["StandingsTable"]["StandingsLists"][0]["DriverStandings"].each do |driver|
      self.standings[driver["position"]] = ["#{driver["Driver"]["givenName"]} #{driver["Driver"]["familyName"]}",driver["wins"],driver["points"]]
    end
    self.standings
  end
  #shows the upcoming race weekend dates
  def self.upcoming_race_weekends
    response = File.read(URI.open("http://ergast.com/api/f1/current.json"))
    json = JSON.parse(response)
    json["MRData"]["RaceTable"]["Races"].each do |race|

      if(Date.today  <= DateParser.parse_date(race["FirstPractice"]["date"]))
        self.schedule[race["raceName"]] = Array.new
        self.schedule[race["raceName"]] << {FirstPractice: DateParser.parse_date(race["FirstPractice"]["date"])}
        self.schedule[race["raceName"]] << {SecondPractice: DateParser.parse_date(race["SecondPractice"]["date"])}
        if(race["ThirdPractice"].nil?)
          self.schedule[race["raceName"]] << {ThirdPractice: DateParser.parse_date(race["Sprint"]["date"])}
        else
          self.schedule[race["raceName"]] << {ThirdPractice: DateParser.parse_date(race["ThirdPractice"]["date"])}
        end
        self.schedule[race["raceName"]] << {Qualifying: DateParser.parse_date(race["Qualifying"]["date"])}
        self.schedule[race["raceName"]] << {RaceDay: DateParser.parse_date(race["date"])}
      end
    end
    self.schedule
  end

  def self.first_practice
  end
  def self.second_practice
  end
  def self.third_practice
  end
  def self.qualifying
  end
  def self.race_day

  end
  ##mm-dd-yyyy
  def self.search_by_date(date)
    input = DateParser.parse_input_date(date)
    eventName = ""
    raceName = ""
    self.schedule.find do |key,event|
      raceName = key
      eventName = event.find do |eventDate|
         eventDate.values[0] = input
      end
    end
    "#{raceName}: #{eventName.keys[0]}"
  end

end
#"Bahrain Grand Prix"=>[{:FirstPractice=>#<Date: 2022-03-18 ((2459657j,0s,0n),+0s,2299161j)>},
#{:SecondPractice=>#<Date: 2022-03-18 ((2459657j,0s,0n),+0s,2299161j)>},
#{:ThirdPractice=>#<Date: 2022-03-19 ((2459658j,0s,0n),+0s,2299161j)>},
#{:Qualifying=>#<Date: 2022-03-19 ((2459658j,0s,0n),+0s,2299161j)>},
#{:RaceDay=>#<Date: 2022-03-20 ((2459659j,0s,0n),+0s,2299161j)>}]

puts Formula1ApiCalls.upcoming_race_weekends

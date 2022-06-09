require 'open-uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
require_relative '../DateParser'
class Formula1Api

  @@standings = {}
  @@current_round = 0
  @@schedule = {}
  @@constructors_standings = {}

  def self.standings
    @@standings
  end
  def self.current_round
    @@current_round
  end

  def self.constructors_standings
    @@constructors_standings
  end

  def self.schedule
    @@schedule
  end

  def self.currentDriverStandings
    response = URI.open('http://ergast.com/api/f1/2022/driverStandings.json').string
    json = JSON.parse(response)
    @@current_round = json['MRData']['StandingsTable']['StandingsLists'][0]['round']
    json['MRData']['StandingsTable']['StandingsLists'][0]['DriverStandings'].each do |driver|
      self.standings[driver['position']] = ["#{driver['Driver']['givenName']} #{driver['Driver']['familyName']}",driver['wins'],driver['points']]
    end
    self.standings
  end

  def self.constructors
    response = URI.open('http://ergast.com/api/f1/2022/constructorStandings.json').string
    json = JSON.parse(response)
    json['MRData']['StandingsTable']['StandingsLists'][0]['ConstructorStandings'].each do |team|
      self.constructors_standings[team['position']] = {name: team['Constructor']['name'],points: team['points'],wins: team['wins']}
    end
    self.constructors_standings
  end

  def self.parse_race_weekends
    response = File.read(URI.open('http://ergast.com/api/f1/current.json'))
    json = JSON.parse(response)
    json['MRData']['RaceTable']['Races'].each do |race|
      if(Date.today  <= DateParser.parse_date(race['FirstPractice']['date']))
        self.schedule[race['raceName']] = []
        self.first_practice(race)
        self.second_practice(race)
        self.sprint(race)
        self.third_practice(race)
        self.qualifying(race)
        self.race_day(race)
      end
    end
    self.schedule
  end
  #helper methods
  def self.first_practice(race)
      self.schedule[race['raceName']] << {FirstPractice: DateParser.parse_date(race['FirstPractice']['date']), time: race['FirstPractice']['time']}
  end

  def self.second_practice(race)
    self.schedule[race['raceName']] << {SecondPractice: DateParser.parse_date(race['SecondPractice']['date']), time: race['SecondPractice']['time']}
  end
  def self.third_practice(race)
    if(!race['ThirdPractice'].nil?)
      self.schedule[race['raceName']] << {ThirdPractice: DateParser.parse_date(race['ThirdPractice']['date']), time: race['ThirdPractice']['time']}
    end
  end

  def self.sprint(race)
    if(race['ThirdPractice'].nil?)
      self.schedule[race['raceName']] << {SprintRace: DateParser.parse_date(race['Sprint']['date']),time: race['Sprint']['time']}
    end
  end

  def self.qualifying(race)
    self.schedule[race['raceName']] << {Qualifying: DateParser.parse_date(race['Qualifying']['date']),time: race['Qualifying']['time']}
  end

  def self.race_day(race)
    self.schedule[race['raceName']] << {RaceDay: DateParser.parse_date(race['date']),time: race['time']}
  end

end

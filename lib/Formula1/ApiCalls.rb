require 'open-uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
class ApiCalls

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
      self.standings[driver["position"]] = "#{driver["Driver"]["givenName"]} #{driver["Driver"]["familyName"]}"
    end
    self.standings
  end
  #shows the upcoming race weekend dates
  def self.upcoming_race_weekends
    response = File.read(URI.open("http://ergast.com/api/f1/current.json"))
    json = JSON.parse(response)
    json["MRData"]["RaceTable"]["races"].each do |race|
      self.schedule[]
    end
  end
end


puts ApiCalls.upcoming_race_weekends

require_relative './Connection.rb'
require_relative './Teams.rb'
require_relative '../DateParser'
require_relative '../api_connect.rb'
class BaseballApi < ApiConnect
  def self.api_call(url)
    BaseballApi.api_connection(url)
  end
  def self.fetch_all_divisions
    divisions = {"AL": ["East","Central","West"],"NL": ["East","Central","West"]}
    divisions.each do |league,division|
      division.each do |div|
        response = BaseballApi.api_call(URI("https://api-baseball.p.rapidapi.com/standings?group=#{league}%20#{div}&league=1&season=2022"))
        Teams.create_from_collection(response['response']);
      end
    end
  end

  def self.fetch_games_by_team(name)
    dates = DateParser.next_three_dates
    team = Teams.search_team_by_name(name)
    dates.map{|date| BaseballApi.api_call(URI("https://api-baseball.p.rapidapi.com/games?league=1&season=2022&team=#{team.id}&date=#{date}"))}
  end
end

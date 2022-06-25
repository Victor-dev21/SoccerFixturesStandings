require_relative './Connection.rb'
require_relative './Teams.rb'
require_relative '../DateParser'
require_relative '../api_connect.rb'
class BaseballApi < ApiConnect
  #fetches stats for all teams by division

  def self.api_call(url)
    BaseballApi.api_connection(url)
  end
  def self.fetch_all_divisions
    divisions = {"AL": ["East","Central","West"],"NL": ["East","Central","West"]}
    divisions.each do |league,division|
      division.each do |div|
        response = BaseballApi.api_call(URI("https://api-baseball.p.rapidapi.com/standings?group=#{league}%20#{div}&league=1&season=2022"))
        #puts response
        Teams.create_from_collection(response['response']);
      end
    end
  end

  def self.fetch_games_by_team(name)
    dates = DateParser.next_three_dates
    team = Teams.search_team_by_name(name)
    dates.map{|date| BaseballApi.api_call(URI("https://api-baseball.p.rapidapi.com/games?league=1&season=2022&team=#{team.id}&date=#{date}"))}
    #dates.each do |date|
    #  single_game = Connection.establish_connection(URI("https://api-baseball.p.rapidapi.com/games?league=1&season=2022&team=#{team.id}&date=#{date}"))
    #  single_game['response'].each do |game|
    #    puts "#{game['teams']['away']['name']} @ #{game['teams']['home']['name']} #{DateParser.user_friendly_date(DateParser.parse_date(game['date'].split("T")[0]))}"
    #  end
    #end
  end
end
#BaseballApi.fetch_all_divisions
#p BaseballApi.fetch_games_by_team("Yankees")

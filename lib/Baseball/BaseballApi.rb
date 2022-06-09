require_relative './Connection.rb'
require_relative './Teams.rb'
class BaseballApi
  
  def self.fetch_all_divisions
    divisions = {"AL": ["East","Central","West"],"NL": ["East","Central","West"]}
    divisions.each do |league,division|
      division.each do |div|
        response = Connection.establish_connection(URI("https://api-baseball.p.rapidapi.com/standings?group=#{league}%20#{div}&league=1&season=2022"))
        Teams.create_from_collection(response['response']);
      end
    end
  end

  def self.all_divisions
    #self.american_league_east
    #self.american_league_west
    #self.american_league_central
    #self.national_league_east
    #self.national_league_west
    #self.national_league_central
    self.fetch_all_divisions
  end
end
#BaseballApi.american_league_central
#puts Teams.all[0].team_name
#puts Connection.establish_connection(URI("https://api-baseball.p.rapidapi.com/standings?group=NL%20East&league=1&season=2022"))

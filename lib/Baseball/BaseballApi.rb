require_relative './Connection.rb'
class BaseballApi
  def self.baseball_team_standings
    response = Connection.establish_connection(URI("https://api-baseball.p.rapidapi.com/standings?league=1&stage=MLB%20-%20Regular%20Season&season=2022"))
  end

  def self.standings_by_division
    url = Connection.establish_connection(URI("https://api-baseball.p.rapidapi.com/standings?group=AL%20East&league=1&season=2022"))
  end
end

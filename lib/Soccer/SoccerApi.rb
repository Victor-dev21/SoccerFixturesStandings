require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
require_relative '../api_connect.rb'
class SoccerApi < ApiConnect

	@@leagues = {LaLiga: 140, Premier: 39, BundesLiga: 78, SerieA: 135, MLS:253, Liga_Mx:262, Ligue_1: 61, World_Cup: 1}
	def self.leagues
		@@leagues
	end

	def self.soccer_api_call(url)
		SoccerApi.api_connection(url)
	end
	def self.latest_fixtures_by_league(league_id)
		if(league_id == 1)
			return SoccerApi.soccer_api_call(URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=1&season=2022"))
		else
		current_season = Date.today.year
		current_round = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures/rounds?league=#{league_id}&season=#{current_season}&current=true")
		current_round = SoccerApi.soccer_api_call(current_round)['response'][0]
		SoccerApi.soccer_api_call(URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=#{league_id}&season=2022&round=#{current_round}"))
	end
	end
	#all games left for the season
	## called once soccer option is selected
	def self.remaining_fixtures_by_league(league_id)
		if(league_id == 1)
			return SoccerApi.soccer_api_call(URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=1&season=2022"))
		else
			current_season = Date.today.year
			todays_date = Date.today.to_s
			league = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=#{league_id}&season=#{current_season}&from=#{todays_date}&to=#{Date.today.next_year.year}-06-15")
			return SoccerApi.soccer_api_call(league)
		end
	end

	def self.top_scorers_by_league(league_id)
		url = URI("https://api-football-v1.p.rapidapi.com/v3/players/topscorers?league=#{league_id}&season=2022")
		response = SoccerApi.soccer_api_call(url)
		response['response']
	end

	def self.standings_by_league(league_id)
		url = URI("https://api-football-v1.p.rapidapi.com/v3/standings?season=2022&league=#{league_id}")
		response = SoccerApi.soccer_api_call(url)
		if(league_id == 1)
			standings = response['response'][0]['league']['standings']
		else
			standings = response['response'][0]['league']['standings'][0]
		end

	end
end

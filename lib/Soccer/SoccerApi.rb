require 'uri'
require 'net/http'
require 'openssl'
require 'json'
require 'date'
require_relative '../ApiConnection'
class SoccerApi
	@@fixtures
	@@teams
	@@teams_to_id = Hash.new
	LaLiga = 140
	Premier_League = 39
	Bundesliga = 78
	SerieA = 135
	Mls = 253
	Liga_MX= 262
	Ligue_1 = 61
	@@top_leagues_id=[LaLiga,Premier_League,SerieA,Bundesliga,Ligue_1,Mls,Liga_MX]

	def self.teams_to_id
		@@teams_to_id
	end
	def self.top_leagues_id
		@@top_leagues_id
	end



	# date parameter format: "year-month-day"
	def self.fixtures(date,league_id)
		current_season = Date.today.year
		url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?date=#{date}&league=#{league_id}&season=#{current_season}")
		@@fixtures = url
	end
	# date parameter format: "year-month-day"
	# only from top four european leagues
	def self.display_fixtures_by_date_date(date)
		top_leagues_id.each do |league_id|
		self.fixtures(date,league_id)
		self.display_fixtures(@@fixtures)
		end
	end
	# fixtures is a url endpoint
	def self.display_fixtures(endpoint)
		response = ApiConnection.establish_connection(endpoint)
		if(response['response'].length > 0 && response['response'][0] != nil)
			puts response['response'][0]['league']['name']
			response['response'].each do |team|
			puts"#{team['teams']['home']['name']} vs #{team['teams']['away']['name']} Date:#{team['fixture']['date'][0,10]}"
			end
		end
		puts
	end

	def self.fixtures_by_team(team_name)
		SoccerApi.link_teams_to_id
		id = find_team_id_from_team_name(team_name)
		todays_date = Date.today.to_s
		url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?season=2021&&team=#{id}&from=#{todays_date}&to=2022-06-05")
		display_fixtures(url)
	end
	def self.link_teams_to_id
		top_leagues_id.each do |league_id|
			self.teams(league_id)
			create_hash_for_teams_id(@@teams)
		end
	end

	def self.create_hash_for_teams_id(teams_by_league_url)
		response = ApiConnection.establish_connection(teams_by_league_url)
		response['response'].each do |team|
			@@teams_to_id[team['team']['name']] = team['team']['id']
		end
	end

	def self.teams(league_id)
		current_season = Date.today.year
		url = URI("https://api-football-v1.p.rapidapi.com/v3/teams?league=#{league_id}&season=#{current_season}")
		@@teams = url
	end

	def self.display_teams_with_id
		@@teams_to_id.each do |team,team_id|
			puts "#{team}: #{team_id}"
		end
	end



	def self.print_easy_to_read_json(response)
		response = JSON.parse(response.body.gsub("=>", ":").gsub(":nil,", ":null,"))
		puts JSON.pretty_generate(response)
	end


	# return the team_id from input
	def self.find_team_id_from_team_name(team_name)
		@@teams_to_id.each do |name,id|
			if(name == team_name)
				return id
			end
		end
	end
	def self.latest_fixtures_by_league(league_id)
		current_season = Date.today.year
		current_round = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures/rounds?league=#{league_id}&season=2021&current=true")
		current_round = ApiConnection.establish_connection(current_round)['response'][0]
		url = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=#{league_id}&season=2021&round=#{current_round}")
		display_fixtures(url)
	end
	def self.reamining_fixtures_by_league(league_id)
		current_season = Date.today.year
		todays_date = Date.today.to_s
		league = URI("https://api-football-v1.p.rapidapi.com/v3/fixtures?league=#{league_id}&season=#{current_season}&from=#{todays_date}&to=2022-06-05")
		ApiConnection.establish_connection(league)
		#display_fixtures(league)
	end

	def self.standings_by_league(league_id)
		url = URI("https://api-football-v1.p.rapidapi.com/v3/standings?season=2021&league=#{league_id}")
		response = ApiConnection.establish_connection(url)
		standings =  response['response'][0]['league']['standings'][0]
		puts"Current standings"
		standings.each do |team|
			puts "#{team['rank']}:#{'%-25.30s' % team['team']['name']} \tPoints:#{team['points']} \t Won: #{team['all']['win']} \tDraw: #{team['all']['draw']} \tLost: #{team['all']['lose']}"
		end
	end

	def self.top_scorer_from_each_league
		
	end
	def self.top_scorers_by_league(league_id)
		url = URI("https://api-football-v1.p.rapidapi.com/v3/players/topscorers?league=#{league_id}&season=2021")
		response = ApiConnection.establish_connection(url)
		rank = 0
		response['response'].each do |player|
			puts "#{rank +=1}. #{'%-30.30s' % player['player']['name']}\tGoals:#{player['statistics'][0]['goals']['total']}"
		end

	end
end
url = URI("https://api-football-v1.p.rapidapi.com/v3/players/topscorers?league=39&season=2021")
SoccerApi.top_scorers_by_league(39)
#puts JSON.pretty_generate(response)
#response = ApiConnection.establish_connection(SoccerApi.fixtures("2021-10-31","140"))
#SoccerApi.display_all_matches_for_top_four_leagues_for_a_specific_date("2021-11-07")
#fixture = SoccerApi.fixtures("2021-11-06",SoccerApi::LaLiga)
#SoccerApi.display_matches_by_league(fixture)
#puts"--------------------------------"
#p SoccerApi.teams_to_id
#SoccerApi.display_teams_with_id
#SoccerApi.link_teams_to_id
#p SoccerApi.find_team_id_from_team_name("Barcelona")
#p SoccerApi.find_team_id_from_team_name("Manchester United")
#puts SoccerApi.teams_to_id.length
#puts JSON.pretty_generate(response['response'][2]['teams']['home']['name'])
#puts JSON.pretty_generate(response['response'][2]['teams']['away']['name'])
#SoccerApi.fixtures_by_team("Barcelona")
#SoccerApi.latest_fixtures_by_league(SoccerApi::Mls

#SoccerApi.standings_by_league(SoccerApi::Ligue_1)

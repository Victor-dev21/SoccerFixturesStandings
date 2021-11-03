require_relative 'SoccerApi'
class LaLiga
	attr_accessor :home_team, :away_team, :league_name, :league_id, :date
	@@all_LaLiga_fixtures = []
	def initialize(home_team,away_team,league_name = "La Liga", league_id = 140, date)
		@home_team = home_team
		@away_team = away_team
		@league_name = league_name
		@league_id = league_id
		@date = date
		@@all_LaLiga_fixtures << self
	end
	def self.all_LaLiga_fixtures
		#self.create_matches_from_collection(league_id)
		@@all_LaLiga_fixtures
	end

	def self.create_matches_from_collection(league_id)
		response = SoccerApi.reamining_fixtures_by_league(league_id)
		if(response['response'].length > 0 && response['response'][0] != nil)
			response['response'].each do |team|
				home_team = team['teams']['home']['name']
				away_team = team['teams']['away']['name']
				date = team['fixture']['date'][0,10]
				LaLiga.new(home_team,away_team,date)
			end
		end
	end

	def self.search_upcoming_fixtures_by_team(team_name)
		fixtures = self.all_LaLiga_fixtures.select{|team|team.home_team == team_name || team.away_team == team_name}
		fixtures.each do |match|
		puts "#{match.home_team} vs #{match.away_team} : #{match.date}"
		end
	end

	def self.display_latest_fixtures(league_id)
		SoccerApi.latest_fixtures_by_league(league_id)
	end

	def self.display_remaining_fixtures
		self.all_LaLiga_fixtures.each do |match|
			puts "#{match.home_team} vs #{match.away_team} : #{match.date}"
		end
	end
end
LaLiga.create_matches_from_collection(SoccerApi::LaLiga)
#LaLiga.display_remaining_fixtures
LaLiga.search_upcoming_fixtures_by_team("Barcelona")

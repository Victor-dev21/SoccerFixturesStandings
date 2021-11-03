require_relative 'SoccerApi'
class Fixture
	attr_accessor :home_team, :away_team, :league_name, :league_id, :date
	@@all_fixtures = []
	@@top_four_leagues_id=[140,78,39,135]
	LaLiga = 140
	Premier_League = 39
	Bundesliga = 78
	SerieA = 135
	def self.top_four_leagues_id
		@@top_four_leagues_id
	end
	def initialize(home_team,away_team,league_name, league_id, date)
		@home_team = home_team
		@away_team = away_team
		@league_name = league_name
		@league_id = league_id
		@date = date
		@@all_fixtures << self
	end
	def self.all_fixtures
		#self.create_matches_from_collection(league_id)
		@@all_fixtures
	end
	# create all remaining fixtures for all leagues
	def self.create_matches_from_collection
		top_four_leagues_id.each do |league_id|
		response = SoccerApi.reamining_fixtures_by_league(league_id)
		if(response['response'].length > 0 && response['response'][0] != nil)
			response['response'].each do |team|
				home_team = team['teams']['home']['name']
				away_team = team['teams']['away']['name']
				date = team['fixture']['date'][0,10]
				league_id = team['league']['id']
				league_name = team['league']['name']
				Fixture.new(home_team,away_team,league_name,league_id,date)
			end
		end
	end
	end

	def self.search_upcoming_fixtures_by_team(team_name)
		fixtures = self.all_fixtures.select{|team|team.home_team == team_name || team.away_team == team_name}
		fixtures.each do |match|
		puts "#{match.home_team} vs #{match.away_team} : #{match.date}"
		end
	end
	def self.search_fixtures_by_date(date)
		fixtures = self.all_fixtures.select{|fixture|fixture.date == date}
		fixtures.each do |match|
		puts "#{match.home_team} vs #{match.away_team} : #{match.date}"
		end
	end

	def self.display_latest_fixtures(league_id)
		SoccerApi.latest_fixtures_by_league(league_id)
	end

	def self.display_remaining_fixtures
		self.all_fixtures.each do |match|
			puts "#{match.home_team} vs #{match.away_team} : #{match.date}"
		end
	end
end
#Fixture.create_matches_from_collection
#Fixture.display_remaining_fixtures
#Fixture.search_upcoming_fixtures_by_team("Real Madrid")

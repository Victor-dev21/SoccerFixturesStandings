require_relative 'SoccerApi'
class Fixture
	attr_accessor :home_team, :away_team, :league_name, :league_id, :date
	@@all_fixtures = []
	def initialize(hash)
		@home_team = hash['teams']['home']['name']
		@away_team = hash['teams']['away']['name']
		@league_name = hash['league']['name']
		@league_id = hash['league']['id']
		@date = hash['fixture']['date'][0,10]
		@@all_fixtures << self
	end

	def self.all_fixtures
		@@all_fixtures
	end
	# create all remaining fixtures for all leagues
	def self.create_matches_from_collection
		SoccerApi.leagues.values.each do |league_id|
			response = SoccerApi.remaining_fixtures_by_league(league_id)
			if(response['response'].length > 0 && response['response'][0] != nil)
				response['response'].each do |fixture|
					Fixture.new(fixture)
				end
			end
		end
	end

	def self.search_upcoming_fixtures_by_team(team_name)
		fixtures = self.all_fixtures.select{|team|team.home_team.include?(team_name) || team.away_team.include?(team_name)}
		self.display_fixtures(fixtures)
	end

	def self.search_fixtures_by_date(date)
		fixtures = self.all_fixtures.select{|fixture|fixture.date == date}
		self.display_fixtures(fixtures)
	end
	#**** does not work with world cup id
	def self.fixtures_by_league(league_id)
		self.all_fixtures.select{|fixture|fixture.league_id == league_id}
	end

	def self.display_remaining_fixtures
		self.display_fixtures(self.all_fixtures)
	end
	#refactor if this could be removed
	#this shows the current this weeks games
	def self.display_current_round_fixtures(league_id)
		response = SoccerApi.latest_fixtures_by_league(league_id)
		#display_fixtures(response['response'])
		if(response['response'].length > 0 && response['response'][0] != nil)
			response['response'].each do |match|
				puts "#{match['teams']['home']['name'].ljust(13)} vs #{match['teams']['away']['name'].ljust(13)} #{match['fixture']['date'][0,10]} "
			end
		end
	end

	def self.display_fixtures(fixtures)
		fixtures.each do |match|
			puts "#{match.home_team.ljust(10)} vs #{match.away_team.ljust(10)} #{match.date}"
		end
	end
end

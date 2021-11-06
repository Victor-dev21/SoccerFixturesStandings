require_relative './SoccerApi'
class LeagueStats
	attr_accessor :name, :goals, :league_id
	@@all_goal_scorers = []
	def initialize(name,goals,league_id)
		@name = name
		@goals = goals
		@league_id = league_id
		@@all_goal_scorers << self
	end

	def self.all_goal_scorers
		@@all_goal_scorers
	end

	def self.standings_by_league_id(league_id)
		standings = SoccerApi.standings_by_league(league_id)
		puts"Current standings"
		standings.each do |team|
			puts "#{team['rank']}:#{'%-25.30s' % team['team']['name']} \tPoints:#{team['points']} \t Won: #{team['all']['win']} \tDraw: #{team['all']['draw']} \tLost: #{team['all']['lose']}"
		end
	end

	def self.top_scorers_by_league_id(league_id)
		#SoccerApi.top_scorers_by_league(id)
		players = all_goal_scorers.select{|player| player.league_id == league_id}
		rank = 0
		players.each do |player|
			puts "#{rank +=1}. #{'%-30.30s' % player.name}\tGoals:#{player.goals}"
		end
	end

	def self.top_scorers_for_all_leagues
		SoccerApi.leagues_id.each do |id|
			collection = SoccerApi.top_scorers_by_league(id)
			store_player_and_goals(collection)
		end
	end

	def self.store_player_and_goals(collection)
		collection.each do |player|
			name = player['player']['name']
			goals = player['statistics'][0]['goals']['total']
			league_id = player['statistics'][0]['league']['id']
			LeagueStats.new(name,goals,league_id)
		end
	end
end

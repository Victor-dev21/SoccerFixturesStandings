require_relative './SoccerApi'
class LeagueStats
	attr_accessor :name, :goals, :league_id
	@@goal_scorers = []
	def initialize(player)
		@name = player['player']['name']
		@goals = player['statistics'][0]['goals']['total']
		@league_id = player['statistics'][0]['league']['id']
		@@goal_scorers << self
	end

	def self.goal_scorers
		@@goal_scorers
	end
	# world cup response has a different format
	def self.standings_by_league_id(league_id)
		standings = SoccerApi.standings_by_league(league_id)
		puts"Current standings"
		if(league_id != 1)
			standings.each do |team|
				puts "#{team['rank']}:#{'%-25.30s' % team['team']['name']} \tPoints:#{team['points']} \t Won: #{team['all']['win']} \tDraw: #{team['all']['draw']} \tLost: #{team['all']['lose']}"
			end
		else
			standings.each do |teams|
			 	puts teams[0]['group']
				teams.each{|team| puts "#{team['rank'].to_s.ljust(0)}. #{team['team']['name'].ljust(14)} Points: #{team['points'].to_s.ljust(5)}Won:#{team['all']['win']} Draw:#{team['all']['draw']} Lose:#{team['all']['lose']}"}
	 		end
		end
	end

	def self.top_scorers_by_league_id(league_id)
		players = goal_scorers.select{|player| player.league_id == league_id}
		rank = 0
		players.each do |player|
			puts "#{rank +=1}. #{'%-30.30s' % player.name}\tGoals:#{player.goals}"
		end
	end

	def self.create_players
		SoccerApi.leagues.values.each do |id|
			SoccerApi.top_scorers_by_league(id).each do |player|
				LeagueStats.new(player)
			end
		end
	end
end

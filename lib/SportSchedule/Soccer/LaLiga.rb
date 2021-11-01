class LaLiga
	attr_accessor :team_name, :team_id,:league_name, :league_id

	def initialize(team_name, team_id,league_name, league_id)
		@team_name = team_name
		@team_id = team_id
		@league_name = league_name
		@league_id = league_id
	end

	def self.create_matches_from_collection
	end
end

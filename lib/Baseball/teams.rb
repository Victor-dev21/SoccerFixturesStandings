class Teams
  attr_accessor :name, :division, :wins, :losses, :last_five_games, :position
  @@all = []
  def initialize(team_hash)
    @name = team_hash['team']['name']
    @position = team_hash['position']
    @division = team_hash['group']['name']
    @wins = team_hash['games']['win']['total']
    @losses = team_hash['games']['lose']['total']
    @last_five_games = team_hash['form']
    @@all << self
  end

  def self.all
    @@all
  end
  def self.create_from_collection(teams_array)
    teams_array.each do |teams|
      teams.each do |team_attr|
        Teams.new(team_attr)
      end
    end
  end

  def self.american_league
    self.all.select{|team| team.division.include?("AL")}
  end

  def self.national_league
    self.all.select{|team| team.division.include?("NL")}
  end

  def self.display_teams
    puts "American League"
    self.american_league.each do |team|
      puts "#{team.position}. #{team.name.ljust(20)} #{team.division} Wins:#{team.wins} Losses:#{team.losses} Last five:#{team.last_five_games}"
    end
    puts "National League"
    self.national_league.each do |team|
      puts "#{team.position}. #{team.name.ljust(20)} #{team.division} Wins:#{team.wins} Losses:#{team.losses} Last five:#{team.last_five_games}"
    end
  end

end

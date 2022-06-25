class Teams
  attr_accessor :name, :division, :wins, :losses, :last_five_games, :position, :id
  @@all = []
  def initialize(team_hash)
    @name = team_hash['team']['name']
    @position = team_hash['position']
    @division = team_hash['group']['name']
    @wins = team_hash['games']['win']['total']
    @losses = team_hash['games']['lose']['total']
    @last_five_games = team_hash['form']
    @id = team_hash['team']['id']
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

  def self.search_team_by_name(name)
    self.all.find{|team| team.name.downcase.include?(name.downcase)}
  end
  def self.display_teams
    puts "American League"
    print_team_stats(self.american_league)
    puts "National League"
    print_team_stats(self.national_league)
  end

  def self.print_team_stats(division)
    flag = 0 # used as indicator whether or not to print division name
    teams_per_division = 5
    division.each do |team|
      puts team.division if (flag % teams_per_division) == 0
      puts "#{team.position}. #{team.name.ljust(25)} Wins:#{team.wins.to_s.ljust(5)} Losses:#{team.losses.to_s.ljust(5)} Last five:#{team.last_five_games}"
      flag +=1
    end
  end
end

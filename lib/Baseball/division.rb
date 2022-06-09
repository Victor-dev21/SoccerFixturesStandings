class Division
  attr_accessor :name
  @@divisions = {}
  def initialize(division)
    division[:name] = name
  end


  def self.divisions
    @@divisions
  end

  def self.american_league

  end

end

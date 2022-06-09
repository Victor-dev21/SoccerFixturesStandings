class Division
  attr_accessor :name
  @@divisions = []
  def initialize(name)
    @name = name
  end


  def self.divisions
    @@divisions
  end

end

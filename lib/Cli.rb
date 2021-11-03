require_relative './Soccer/SoccerApi'
class Cli
	def run
		display_options
	end


def display_options
	puts"Welcome, search upcoming fixtures for your favorite sports, favorite teams, or your favorite soccer leagues."
	puts"Available sports: Soccer, Formula 1"
	puts"Please select a number:  "
	puts"1. Soccer"
	puts"2. Formula 1"
	puts
end

end
Cli.new.rub

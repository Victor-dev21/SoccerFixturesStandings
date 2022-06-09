require_relative './Soccer/soccer_ui'
require_relative './Formula1/FormulaOneUI'
require_relative './Baseball/baseballUI'
class Cli
	def run

		main_page
		#SoccerUI.new.soccer_options
	end
	def main_page
		puts "Choose a sport from the following list press 'q' to quit"
		puts "1. Soccer"
		puts "2. Formula 1"
		puts "3. MLB"
		input = gets.strip
		if input != "q"
			if(input == "1")
				SoccerUI.new.soccer_options
			elsif(input == "2")
				FormulaOneUI.new.options
			elsif(input == "3")
				BaseballUI.new.options
			end
		end
	end

end
Cli.new.run

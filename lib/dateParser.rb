require 'date'
require 'pry'
class DateParser
  def self.parse_date(input)
		input = input.split("-")
    month = input[1].to_i
		date = input[2].to_i
		year = input[0].to_i
		Date.new(year,month,date)
	end

  def self.parse_input_date(input)
		input = input.split("-")
		date = input[1].to_i
		month = input[0].to_i
		year = input[2].to_i
		Date.new(year,month,date)
	end
end
puts DateParser.parse_date("2022-03-20")
puts DateParser.parse_input_date("03-20-2022") == DateParser.parse_date("2022-03-20")

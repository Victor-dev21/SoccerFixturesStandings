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

  def self.user_friendly_date(date)
    day = date.day
    year = date.year
    month = date.month
    "#{month}/#{day}/#{year}"
  end

  def self.parse_time(time)
  time = time.split(":")[0].to_i - 4
  eventTime = ""
  if(time > 12)
    time = time-12
    eventTime = "#{time}:00pm est"
  elsif((time-12) == 0 && time !=0)
    eventTime = "#{time}:00pm est"
  elsif(time == 0)
    eventTime = "12:00am est"
  else
    eventTime = "#{time}:00am est"
  end
    eventTime
  end
end

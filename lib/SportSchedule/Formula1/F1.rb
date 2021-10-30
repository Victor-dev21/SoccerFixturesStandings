require 'nokogiri'
require 'open-uri'
require_relative 'F1Scraper'
class FormulaOne

	#@@hash = Hash.new.compare_by_identity
	@@all = []
	@@months = ["","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"]
	@@grand_prixs = []
	@@all_f1_events_by_date = Hash.new.compare_by_identity # store all f1 events by date
	attr_accessor :event_name, :date

	def initialize(event_name, date)
		@event_name = event_name
		@date = date
		@@all << self
	end
	def self.all_f1_events_by_date
		@@all_f1_events_by_date
	end

	def self.all
		@@all
	end

	def self.grand_prixs
		@@grand_prixs
	end

	def self.months
		@@months
	end
	# creates day objects depending on day
	# friday fp1 and fp2
	# Saturday fp3 and qualit
	# Sunday race
	def self.create_event_from_collection
		current_year = Date.today.year
		race_number = 0
		circuits = F1Scraper.grand_prixs
		self.parse_race_weekend.each do |key,value|
	 	month = self.months.index(key)
	 	day = value
		fp1_fp2_date = Date.new(current_year,month,day)
		fp_1 = FormulaOne.new("FP1 & fp2",fp1_fp2_date)
		#fp_2 = FormulaOne.new("FP2",fp1_fp2_date)
		store_in_hash(fp1_fp2_date,fp_1.event_name)

		f1_quali_date = fp1_fp2_date.next_day
		f1_qualifying = FormulaOne.new("Fp3 & Qualifying",f1_quali_date)
		store_in_hash(f1_quali_date,f1_qualifying.event_name)

		f1_race_date = f1_quali_date.next_day
		f1_race_day = FormulaOne.new(circuits[race_number],f1_race_date)
		race_number +=1
		store_in_hash(f1_race_date,f1_race_day.event_name)
		end
	end

	def self.store_in_hash(date,event_name)
		if(self.all_f1_events_by_date[date] == nil)
			self.all_f1_events_by_date[date]=[]
			self.all_f1_events_by_date[date] << event_name
		else
			self.all_f1_events_by_date[date] << event_name
		end
	end



	def self.find_event_by_day(input)
		users_date = Day.parse(input)
		day_of_month = users_date.day
		month = users.month
		FormulaOne.create_event_from_collection
		FormulaOne.all.each do |obj|
			if(obj.date.day == day_of_month && obj.date.month == month)
				puts "#{obj.event_name} on #{obj.date}"
			end
		end
	end
	# year-month-day
	def self.find_event_by_date(input)
		date = self.parse_input_date(input)
		FormulaOne.create_event_from_collection
		FormulaOne.all.each do |obj|
			if(obj.date.day == date.day && obj.date.month == date.month)
				puts "#{obj.event_name} on #{obj.date}"
			end
		end
	end
	#date entered by the user
	def self.parse_input_date(date)
		array = date.split("-")
		current_year = array[0].to_i
		month = array[1].to_i
		day_of_month = array[2].to_i
		Date.new(current_year,month,day_of_month)
	end

	def self.parse_race_weekend
	hash = Hash.new.compare_by_identity
	F1Scraper.scrape_race_weekends.each do |date|
		date = date.split(" ")
				hash[date[0]] = date[1].to_i
		end
		hash
	end

	# stores all grand prix races into array
	def self.create_grand_prix_from_collection
		F1Scraper.scrape_grand_prix_names.each do |event|
			self.grand_prixs << event.text
		end
	end
end
#f1_calendar = FormulaOne.create_grand_prix_from_collection
#p FormulaOne.create_event_from_collection
#FormulaOne.all.each do |obj|
#	puts "#{obj.event_name} #{obj.date}"
#end
#p FormulaOne.all.size
#FormulaOne.create_event_from_collection.size
#FormulaOne.find_event_by_date("2021-12-12")
#p FormulaOne.parse_race_weekend
#FormulaOne.create_event_from_collection
 #FormulaOne.all_f1_events_by_date.each do |event|
	# puts "#{event[0]}: #{event[1]}"
 #end
 p FormulaOne.parse_race_weekend

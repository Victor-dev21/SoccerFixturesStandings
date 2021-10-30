require 'nokogiri'
require 'open-uri'
class Motor
	@@hash = Hash.new


	@@hash = Hash.new.compare_by_identity

	def self.hash
		@@hash
	end

	def self.call
		p self.hash
	end
end
Motor.call

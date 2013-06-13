#!/usr/bin/ruby

require './config.rb'

class Job
	attr_reader :data

	def initialize hash_data
		@data = hash_data
		[:start, :end].each do |x|
			convert_time x
		end
	end
	
	private
	def convert_time key
		if @data.has_key? key then
			tmp = @data[key]
			time = Time.parse tmp
			@data[key] = time
		end
	end

	public
	def epoch_time_of key
		return data[key].to_i
	end	

	def seconds_between first, second
		return data[second].to_i - data[first].to_i
	end
end


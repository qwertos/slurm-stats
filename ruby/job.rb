#!/usr/bin/ruby

class Job
	attr_reader :data

	def initialize hash_data
		@data = hash_data
	end

	def epoch_time_of key
		return Time.parse(data[key]).to_i
	end	

	def seconds_between first, second
		return Time.parse(data[second]).to_i - Time.parse(data[first]).to_i
	end
end


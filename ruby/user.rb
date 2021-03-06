#!/usr/bin/ruby

require './time.rb'
require './job.rb'

class User
	attr_accessor :username
	attr_reader :jobs

	def initialize 
		@username = ""
		@jobs = []
	end

	def add_job job
		@jobs.push job
	end

	def total_time_elapsed
		toReturn = 0
		@jobs.each do |x|
			toReturn += x.seconds_between :start, :end
		end
		return toReturn
	end
	
	def get_usage_days
		toReturn = {}
		
		@jobs.each do |job|
			start_dc = job.date_code_of :start
			
			if toReturn.has_key? start_dc then
				toReturn[start_dc] += job.seconds_between :start, :end
			else
				toReturn[start_dc] = job.seconds_between :start, :end
			end
		end
		
		return toReturn
	end

	def to_tsv
		toReturn  = ""
		toReturn += '# '
		toReturn += @username
		toReturn += "\n"

		get_usage_days.to_a.each do |x|
			toReturn += x.join( "\t" )
			toReturn += "\n"
		end

		toReturn += "\n"

		return toReturn
	end
end



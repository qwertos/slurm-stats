#!/usr/bin/ruby

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
		
	end
end



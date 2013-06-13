#!/usr/bin/ruby

require './job.rb'

class User
	attr_accessor :jobs, :username
	
	def initialize 
		@username = ""
		@jobs = []
	end
end



#!/usr/bin/ruby

class Job
	attr_accessor :jobid, :partition, :user, :elapsed, :submit, :start, :end
	
	def initialize 
		@jobid = nil
		@partition = nil
		@user = nil
		@elapsed = nil
		@submit = nil
		@start = nil
		@end = nil
	end
end


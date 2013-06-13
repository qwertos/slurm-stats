#!/usr/bin/ruby

include './user.rb'
include './job.rb'
include './config.rb'

$USERS = {}
$JOBS = {}

def main
	if $REGEN_PSV_DUMP then
		`sacct -L -P --starttime=0601 -n --format=jobid,partition,user,elapsed,submit,start,end > #{$PSV_DUMP}`
	end

	File.open( $PSV_DUMP , 'r' ) do |file|
		
		file.each_line do |line|
			splitted = line.split( /\|/, 7 )
			
			temp_job = Hash[ $SLURM_VALUES.zip(splitted)]
			
			$JOBS[temp_job['jobid']] = temp_job
			
			
		end
		
	end




end


main

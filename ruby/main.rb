#!/usr/bin/ruby

require './user.rb'
require './job.rb'
require './config.rb'

$USERS = {}
$JOBS = {}

def main
	puts "Beginning Processing..."
	if $REGEN_PSV_DUMP then
		puts "Regening PSV dump..."
		`sacct -L -P -n --format=#{gen_format_line} > #{$PSV_DUMP}`
		puts "Regening PSV dump... DONE"
	end
	
	puts "Processing PSV file..."
	File.open( $PSV_DUMP , 'r' ) do |file|
		
		file.each_line do |line|
			splitted = line.split( /\|/, $SLURM_VALUES.size )
			
			temp_job = Job.new(Hash[ $SLURM_VALUES.zip(splitted)])
			
			$JOBS[temp_job.data[:jobid]] = temp_job

			if $USERS.has_key? temp_job.data[:user] then
				$USERS[temp_job.data[:user]].add_job temp_job
			else
				temp_user = User.new
				temp_user.add_job temp_job
				temp_user.username = temp_job.data[:user]
				$USERS[temp_job.data[:user]] = temp_user
			end
		end
	end

	$USERS.each do |key, value|
		File.open( "#{$USER_USE_DIR}/#{key}.dat" , "rw" ) do |file|
			file.puts value.to_tsv
		end
	end

		

end


def gen_format_line
	return $SLURM_VALUES.join ','
end


main


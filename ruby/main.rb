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
		File.open( "#{$USER_USE_DIR}/#{key}.dat" , "w" ) do |file|
			file.puts value.to_tsv
		end
	end

	gen_plot_file	

end


def gen_format_line
	return $SLURM_VALUES.join ','
end

def gen_plot_file
	File.open( $PLOT_FILE , "w" ) do |file|
		file.puts "#!/usr/bin/gnuplot"
		file.puts ""
		file.puts "set terminal postscript"
		file.puts "set output 'plot.ps'"
		file.puts "set autoscale"
		file.puts "unset log"
		file.puts "unset label"
		file.puts "set xtic auto"
		file.puts "set ytic auto"
		file.puts ""
		file.puts "set title 'Slurm user usage over time'"
		file.puts "set xlabel 'datestamp'"
		file.puts "set ylabel 'time used for jobs started at datestamp'"
		file.puts ""
		file.print "plot "
		$USERS.each do |key, value|
			file.print "'#{$USER_USE_DIR}/#{key}.dat' using 1:2 title '#{key}' with linespoints , "
		end
		file.puts ""
	end
end


main


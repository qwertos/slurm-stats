

$TMP_DIR = "/dev/shm/accountingrb"
$PSV_DUMP = "#{$TMP_DIR}/data.psv"
$REGEN_PSV_DUMP = true
$SLURM_VALUES = [
	:jobid,
	:partition,
	:user,
	:elapsed,
	:submit,
	:start,
	:end
]


#DO NOT modify these unless you know what you are doing

class Job
	@@TIME_KEYS = [
		:submit,
		:start,
		:end
	]
end


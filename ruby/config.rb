

$TMP_DIR = "/dev/shm/accountingrb"
$PSV_DUMP = "#{$TMP_DIR}/data.psv"
$USER_USE_DIR = "#{$TMP_DIR}/users"
$REGEN_PSV_DUMP = false
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


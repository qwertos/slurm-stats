

$TMP_DIR = "/dev/shm/accounting/"
$PSV_DUMP = "#{$TMP_DIR}/dump.psv"
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


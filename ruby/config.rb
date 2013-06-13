

$TMP_DIR = "/dev/shm/accounting/"
$PSV_DUMP = "#{$TMP_DIR}/dump.psv"
$REGEN_PSV_DUMP = false
$SLURM_VALUES = [
	"jobid",
	"partition",
	"user",
	"elapsed",
	"submit",
	"start",
	"end"
]


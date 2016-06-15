<snap.mk
# snap fails if more than one snap process is active
NPROC=1

SNAP_TARGETS=`{./snap-nt-queue}

align-nt:V:	$SNAP_TARGETS

# snap can filter a set of files and it's more efficient to align them all on the same run
# rather than running surpi once for each file

'results/align-nt/(.*)_(.*).sam':RD:	'data/\1'	$SNAP_REFERENCEDIR'/\2'
	mkdir -p `dirname $target`
	SNAP_FILES=`find -L \
		data/$stem1 \
		-name '*.fastq' \
		-o -name '*.fastq.gz' \
		-o -name '*.sam' \
		-o -name '*.bam'`
	snap-aligner \
		single \
		$SNAP_REFERENCEDIR/$stem2 \
		$SNAP_FILES \
		$SNAP_OPTS \
		-o -sam - \
		> $target

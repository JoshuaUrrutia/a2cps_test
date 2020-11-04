# Import Agave runtime extensions
. _lib/extend-runtime.sh

# Allow CONTAINER_IMAGE over-ride via local file
if [ -z "${CONTAINER_IMAGE}" ]
then
    if [ -f "./_lib/CONTAINER_IMAGE" ]; then
        CONTAINER_IMAGE=$(cat ./_lib/CONTAINER_IMAGE)
    fi
    if [ -z "${CONTAINER_IMAGE}" ]; then
        echo "CONTAINER_IMAGE was not set via the app or CONTAINER_IMAGE file"
        CONTAINER_IMAGE="jurrutia/ubuntu17"
    fi
fi

# BUG Input Directory ${BIDS_DIRECTORY} not defined
# using some bash tricks to get if from the participant label
DIR=*/${PARTICIPANT_LABEL}
DIR=$(echo ${DIR} | cut -d "/" -f1)
echo Input is ${DIR}


# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a

mkdir -p  ${OUTPUT_DIR}/work
PYTHONPATH=""
# Echo command to std out
echo container_exec ${CONTAINER_IMAGE} \
               ${DIR} \
               ${OUTPUT_DIR} \
               participant --participant_label ${PARTICIPANT_LABEL} \
               -w  ${OUTPUT_DIR}/work \
               --write-graph \
               --fd-spike-threshold ${FD_SPIKE_THRESHOLD} \ 
               --n-cpus 16 \
               --notrack \
               --fs-no-reconall \
               --use-aroma  \
               --mem_mb 48000 \
               --fs-license-file /opt/license.txt

container_exec ${CONTAINER_IMAGE} \
               ${DIR} \
               ${OUTPUT_DIR} \
               participant --participant_label ${PARTICIPANT_LABEL} \
               -w  ${OUTPUT_DIR}/work \
               --write-graph \
               --fd-spike-threshold ${FD_SPIKE_THRESHOLD} \
               --n-cpus 16 \
               --notrack \
               --fs-no-reconall \
               --use-aroma  \
               --mem_mb 48000 \
               --fs-license-file /opt/license.txt


rm -rf ${DIR}

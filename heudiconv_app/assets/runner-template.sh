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


mkdir -p  ${OUTPUT_DIR}
PYTHONPATH=""

# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a

# Echo command to std out
# echo container_exec ${CONTAINER_IMAGE} \
#                   heudiconv \
#                  --dicom_dir_template ${DICOM_DIR_TEMPLATE} | --files ${FILES} \
#                  --subjects ${LIST_OF_SUBJECTS} \
#                  --converter {dcm2niix,none}] \
#                  --outdir ${OUTDIR} \
#                  --locator ${LOCATOR} --conv-outdir ${CONV_OUTDIR} \
#                  --anon-cmd ${ANON_CMD} \
#                  --heuristic ${HEURISTIC} --with-prov \
#                  --ses ${SESSION_FOR_LONGITUDINAL} --bids --overwrite \
#                  --datalad] --dbg \
#                  --grouping {studyUID,accession_number} --minmeta \
#                  --random-seed ${RANDOM_SEED} --dcmconfig ${DCMCONFIG} \
#
#
# container_exec ${CONTAINER_IMAGE} \
# heudiconv \
# --dicom_dir_template ${DICOM_DIR_TEMPLATE} | --files ${FILES} \
# --subjects ${LIST_OF_SUBJECTS} \
# --converter {dcm2niix,none}] \
# --outdir ${OUTDIR} \
# --locator ${LOCATOR} --conv-outdir ${CONV_OUTDIR} \
# --anon-cmd ${ANON_CMD} \
# --heuristic ${HEURISTIC} --with-prov \
# --ses ${SESSION_FOR_LONGITUDINAL} --bids --overwrite \
# --datalad] --dbg \
# --grouping {studyUID,accession_number} --minmeta \
# --random-seed ${RANDOM_SEED} --dcmconfig ${DCMCONFIG} \

echo container_exec ${CONTAINER_IMAGE} \
  heudiconv \
  -f ./spacetop.py \
  -a ${OUTPUT_DIR}/sub-0001/ses-01 \
  -s 0001 -ss 01 \
  --anon-cmd M80303495 --overwrite \
  --files ${DICOM_DIR_TEMPLATE}/M80303495/Study20200114at144741/ \
  --locator ${OUTPUT_DIR}

container_exec ${CONTAINER_IMAGE} \
  heudiconv \
  -f ./spacetop.py \
  -a ${OUTPUT_DIR}/sub-0001/ses-01 \
  -s 0001 -ss 01 \
  --anon-cmd M80303495 --overwrite \
  --files ${DICOM_DIR_TEMPLATE}/M80303495/Study20200114at144741/ \
  --locator ${OUTPUT_DIR}

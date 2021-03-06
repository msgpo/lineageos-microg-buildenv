#! /bin/sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker pull lineageos4microg/docker-lineage-cicd

docker run \
    --name=lineage-$(date +%Y%m%d_%H%M) \
    --rm \
    -it \
    -e "USER_NAME=Fabian Köster" \
    -e "USER_MAIL=mail@fabian-koester.com" \
    -e "WITH_SU=false" \
    -e "DEVICE_LIST=${DEVICES}" \
    -e "BRANCH_NAME=${BRANCH_NAME}" \
    -e "CRONTAB_TIME=now" \
    -e "CUSTOM_PACKAGES=FDroid FDroidPrivilegedExtension" \
    -e "SIGN_BUILDS=true" \
    -e "CLEAN_OUTDIR=false" \
    -e "CLEAN_AFTER_BUILD=true" \
    -e "ZIP_SUBDIR=true" \
    -e "LOGS_SUBDIR=true" \
    -e "DELETE_OLD_ZIPS=3" \
    -e "DELETE_OLD_LOGS=3" \
    -e "INCLUDE_PROPRIETARY=${INCLUDE_PROPRIETARY}" \
    -v "${DIR}/work/cache:/srv/ccache" \
    -v "${DIR}/work/lineage:/srv/src" \
    -v "${DIR}/work/zips:/srv/zips" \
    -v "${DIR}/work/logs:/srv/logs" \
    -v "${DIR}/keys:/srv/keys" \
    -v "${DIR}/${LOCAL_MANIFESTS}:/srv/local_manifests" \
    -v "${DIR}/scripts:/srv/userscripts" \
    lineageos4microg/docker-lineage-cicd

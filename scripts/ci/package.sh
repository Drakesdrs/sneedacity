#!/usr/bin/env bash

((${BASH_VERSION%%.*} >= 4)) || { echo >&2 "$0: Error: Please upgrade Bash."; exit 1; }

set -euxo pipefail

cd build

if [[ "${OSTYPE}" == msys* && ${GIT_BRANCH} == release* ]]; then # Windows
    cmake --build . --target innosetup --config "${SNEEDACITY_BUILD_TYPE}"
else
    cpack -C "${SNEEDACITY_BUILD_TYPE}" --verbose
fi

# Remove the temporary directory
rm -Rf package/_CPack_Packages

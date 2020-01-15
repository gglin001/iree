#!/bin/bash

# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Build the project with cmake using Kokoro.

set -e
set -x

# Print the UTC time when set -x is on
export PS4='[$(date -u "+%T %Z")] '

export CMAKE_BIN="$(which cmake)"
export CC="$(which clang-6.0)"
export CXX="$(which clang++-6.0)"

# Check these exist and print the versions for later debugging
"$CMAKE_BIN" --version
"$CC" --version
"$CXX" --version

# Kokoro checks out the repository here.
cd ${KOKORO_ARTIFACTS_DIR?}/github/iree
echo "Initializing submodules"
./git_scripts/submodule_versions.py init

echo "Building and testing with cmake"
./build_tools/scripts/cmake_build.sh

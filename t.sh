git submodule init
git submodule update --init --depth=1 third_party/torch-mlir

# optional: softlink llvm-project

git submodule update --recursive --init --depth=1

# git submodule update --recursive --init
# git submodule update --recursive --init --depth=1 third_party/torch-mlir
# git submodule update --recursive --init --remote third_party/llvm-project
# git submodule deinit -f --all
# git submodule update --recursive --init --depth=1
# git submodule set-url third_party/llvm-project https://github.com/llvm/llvm-project.git

# -----

# clone once
pushd ..
# git clone https://github.com/llvm/llvm-project.git
git clone https://github.com/shark-infra/llvm-project.git
popd

TAG="c51da07d81ac91ca9775502af2cc6171e68bd3da"
mkdir llvm-project-$TAG
pushd llvm-project-$TAG
git init
git remote add origin ../../llvm-project
git fetch --depth 1 origin $TAG
git checkout FETCH_HEAD
git remote set-url origin https://github.com/shark-infra/llvm-project.git
popd

# replace with local repo
rm -rf $PWD/third_party/llvm-project/
ln -sf $PWD/llvm-project-$TAG $PWD/third_party/llvm-project
# git add third_party/llvm-project

# replace with local repo
rm -rf third_party/torch-mlir/externals/llvm-project
ln -sf $PWD/llvm-project-$TAG $PWD/third_party/torch-mlir/externals/llvm-project
pushd third_party/torch-mlir
# git add externals/llvm-project
popd

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
git clone https://github.com/llvm/llvm-project.git
popd

pushd ..
TAG="6b65d79fbb4682468333cea42b62f15c2dffd8f3"
mkdir llvm-project-$TAG
pushd llvm-project-$TAG
git init
git remote add origin ../../llvm-project
git fetch --depth 1 origin $TAG
git checkout FETCH_HEAD
git remote set-url origin git@github.com:llvm/llvm-project.git
popd
popd

# replace with local repo
rm -rf $PWD/third_party/llvm-project/
ln -sf $PWD/llvm-project-$TAG $PWD/third_party/llvm-project
git add third_party/llvm-project

# replace with local repo
rm -rf third_party/torch-mlir/externals/llvm-project
ln -sf $PWD/llvm-project-$TAG $PWD/third_party/torch-mlir/externals/llvm-project
pushd third_party/torch-mlir
git add externals/llvm-project
popd

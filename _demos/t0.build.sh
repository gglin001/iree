###############################################################################

git submodule init
git submodule update --init --depth=1 third_party/torch-mlir
git submodule deinit third_party/llvm-project
git submodule update --depth=1

###############################################################################

# cmake --preset osx
cmake --preset osx_allen

cmake --build $PWD/build --target all

###############################################################################

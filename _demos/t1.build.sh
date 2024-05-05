# cmake --preset iree_llvm -S$PWD/llvm -B$PWD/build
cmake --preset iree_llvm_allen

cmake --build $PWD/build --target all

###############################################################################

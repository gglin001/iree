###############################################################################

# host

# cmake --preset iree_llvm
cmake --preset iree_llvm_allen

cmake --build $PWD/build --target all

###############################################################################

# iree_llvm_riscv

cmake --preset iree_llvm_riscv
cmake --build $PWD/build-riscv --target all

spike pk build-riscv/samples/static_library/static_library_demo

###############################################################################

# iree_llvm_riscv_picolibc_clang_rv64ima_lp64_semihost

cmake --preset iree_llvm_riscv_picolibc_clang_rv64ima_lp64_semihost
cmake --build $PWD/build-riscv-semihost --target all

#####

args=(
  -m 512M
  -machine virt
  -cpu rv64,v=true,vlen=128,elen=64,vext_spec=v1.0
  -semihosting-config enable=on # semihost
  -nographic
  -bios none
  -monitor none
  -serial none
  #
  # -d out_asm
  # -d in_asm
  # -d cpu
  # -d exec
  # -d op
  #
  # -kernel build-riscv-semihost/samples/static_library/static_library_demo
  # -kernel build-riscv-semihost/samples/simple_embedding/simple_embedding_embedded_sync
  -kernel build-riscv-semihost/samples/simple_embedding/simple_embedding_vmvx_sync
)
qemu-system-riscv64 "${args[@]}"

###############################################################################

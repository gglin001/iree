// Copyright 2020 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

#ifndef IREE_HAL_DRIVERS_LOCAL_TASK_TASK_DEVICE_H_
#define IREE_HAL_DRIVERS_LOCAL_TASK_TASK_DEVICE_H_

#include "iree/base/api.h"
#include "iree/hal/api.h"
#include "iree/hal/local/executable_loader.h"
#include "iree/task/executor.h"

#ifdef __cplusplus
extern "C" {
#endif  // __cplusplus

// Parameters configuring an iree_hal_task_device_t.
// Must be initialized with iree_hal_task_device_params_initialize prior to use.
typedef struct iree_hal_task_device_params_t {
  // Number of queues exposed on the device.
  // Each queue acts as a separate synchronization scope where all work executes
  // concurrently unless prohibited by semaphores.
  iree_host_size_t queue_count;

  // Total size of each block in the device shared block pool.
  // Larger sizes will lower overhead and ensure the heap isn't hit for
  // transient allocations while also increasing memory consumption.
  iree_host_size_t arena_block_size;
} iree_hal_task_device_params_t;

// Initializes |out_params| to default values.
void iree_hal_task_device_params_initialize(
    iree_hal_task_device_params_t* out_params);

// Creates a new iree/task/-based local CPU device that uses |executor| for
// scheduling tasks. |loaders| is the set of executable loaders that are
// available for loading in the device context.
iree_status_t iree_hal_task_device_create(
    iree_string_view_t identifier, const iree_hal_task_device_params_t* params,
    iree_task_executor_t* executor, iree_host_size_t loader_count,
    iree_hal_executable_loader_t** loaders,
    iree_hal_allocator_t* device_allocator, iree_allocator_t host_allocator,
    iree_hal_device_t** out_device);

#ifdef __cplusplus
}  // extern "C"
#endif  // __cplusplus

#endif  // IREE_HAL_DRIVERS_LOCAL_TASK_TASK_DEVICE_H_

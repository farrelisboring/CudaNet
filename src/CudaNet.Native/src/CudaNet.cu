#include "exports.h"
#include "CudaNet.h"
#include <iostream>
#include <cuda_runtime.h>

 __global__ void KernelMultiplyFloat32(const float* __restrict__ a_ptr, const float* __restrict__ b_ptr, float* c_ptr, int a_row, int shared_dimension, int b_col) {
         int row = blockIdx.y * blockDim.y + threadIdx.y;
         int col = blockIdx.x * blockDim.x + threadIdx.x;

         if (row < a_row && col < b_col) {
             float sum = 0.0f;
             for (int r = 0; r < shared_dimension; ++r) {
                 float a = a_ptr[row * shared_dimension + r]; //1d
                 float b = b_ptr[r * b_col + col];// 1d
                 sum += a * b;
             }
             c_ptr[row * b_col + col] = sum;
         }
 }
 
    

extern "C" {


    MY_API void MatrixMultiplyFloat32(const float* __restrict__ a_ptr, const float* __restrict__ b_ptr, float* __restrict__ c_buffer, int a_row, int shared_dimension, int b_col) { 
        
        float* allocated_a, * allocated_b, * allocated_c; 
        size_t a_size = sizeof(float) * (size_t) a_row * (size_t)shared_dimension;
        size_t b_size = sizeof(float) * (size_t) b_col * (size_t)shared_dimension;
        size_t c_size = sizeof(float) * (size_t) a_row * (size_t) b_col;


        cudaMalloc((void**)&allocated_a, a_size);
        cudaMalloc((void**)&allocated_b, b_size);
        cudaMalloc((void**)&allocated_c, c_size);

        cudaMemcpy(allocated_b, b_ptr, b_size, cudaMemcpyHostToDevice);
        cudaMemcpy(allocated_a, a_ptr, a_size, cudaMemcpyHostToDevice);


        dim3 block(16, 16);
        dim3 grid((b_col + block.x - 1) / block.x, (a_row + block.y - 1) / block.y);

        KernelMultiplyFloat32 <<< grid, block >>> (allocated_a, allocated_b, allocated_c, a_row, shared_dimension, b_col);

        cudaMemcpy(c_buffer, allocated_c, c_size, cudaMemcpyDeviceToHost);

        
        cudaFree(allocated_a);
        cudaFree(allocated_b);
        cudaFree(allocated_c);
    }
}


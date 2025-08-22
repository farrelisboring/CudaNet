#pragma once



extern "C" {
    MY_API void     MatrixMultiplyFloat32(const float* a_ptr,
        const float* b_ptr,
        float* c_buffer,
        int a_row,
        int shared_dimension,
        int b_col);
}

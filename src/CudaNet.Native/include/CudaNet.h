#pragma once
#include <vector>
#include <cstddef> // size_t


class Context {
public:
    std::vector<int> data;
};


extern "C" {

    MY_API Context* Context_Create();
    MY_API void     Context_Destroy(Context* ctx);

 
    MY_API void     Context_PassPtr(Context* ctx, const int* ptrInt, std::size_t n);
}

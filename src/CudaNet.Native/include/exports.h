#pragma once

#if defined(CUDANETNATIVE_EXPORTS) || defined(CUDANET_EXPORTS)
#define MY_API __declspec(dllexport)
#else
#define MY_API __declspec(dllimport)
#endif

# CudaNet API Reference
Minimal, signature-only reference for the public C# surface area of the C++ interop.

# Namespace
```csharp
namespace CudaNet;
```
Top-level namespace for the C# interop APIs.

# Classes
```csharp
public static class Matrix
```
Static entry point for matrix operations backed by native CUDA implementations.

# Methods
```csharp
public static float[,] MultiplyFloat32(float[,] aMatrix, float[,] bMatrix)
```
Performs single-precision (float32) matrix multiplication C = A × B using the native CUDA kernel via P/Invoke.

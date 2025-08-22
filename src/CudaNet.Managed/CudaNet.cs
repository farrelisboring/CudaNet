using System.Runtime.InteropServices;


namespace CudaNet;

public static class CudaMatrix
{

    [DllImport("NativeCuda", CallingConvention = CallingConvention.Cdecl)]
    private static extern unsafe void MatrixMultiplyFloat32(IntPtr aPtr, IntPtr bPtr, IntPtr buffer, int m, int k, int n);


    public static float[,] MultiplyFloat32(float[,] aMatrix, float[,] bMatrix)
    {
        float[,] cMatrix = new float[aMatrix.GetLength(0), bMatrix.GetLength(1)];
        unsafe
        {
            fixed (float* aPtr = &aMatrix[0, 0], bPtr = &bMatrix[0, 0], c_buffer = &cMatrix[0, 0])
            {
                MatrixMultiplyFloat32((IntPtr)aPtr, (IntPtr)bPtr, (IntPtr)c_buffer, aMatrix.GetLength(0), aMatrix.GetLength(1), bMatrix.GetLength(1)); // calling native functions
            }
        }
        return cMatrix;
    }
}

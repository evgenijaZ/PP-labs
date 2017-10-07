using System;

namespace lab3
{
    class Data
    {
        public Matrix F1(Matrix A, Matrix D, Vector B)
        {
            Matrix E = new Matrix(A.N);
            E = Multiple(Max(B), Multiple(A, D));
            return E;
        }

        public Matrix F2(int A, Matrix G, Matrix K, Matrix L)
        {
            Matrix F = new Matrix(G.N);
            F = Amount(Multiple(A, Trans(G)), Multiple(K, L));
            return F;
        }

        public Vector F3(Matrix P, Matrix R, Vector S, Vector T)
        {
            Vector O = new Vector(P.N);
            O = Amount(Multiple(Multiple(P, R), S), T);
            return O;
        }

        private int Max(Vector A)
        {
            int maxItem = A.Value[0];
            foreach (int aValue in A.Value)
                if (aValue > maxItem) maxItem = aValue;
            return maxItem;
        }

        private Vector Amount(Vector A, Vector B)
        {
            if (A.N != B.N)
            {
                Console.WriteLine("Vectors should have the same length");
                return null;
            }
            Vector C = new Vector(A.N);
            for (int i = 0; i < C.N; i++)
            {
                C.Value[i] = A.Value[i] + B.Value[i];
            }
            return C;
        }

        private Matrix Amount(Matrix A, Matrix B)
        {
            if (A.N != B.N)
            {
                Console.WriteLine("Matrices should have the same dimension");
                return null;
            }
            Matrix C = new Matrix(A.N);
            for (int i = 0; i < C.N; i++)
            {
                for (int j = 0; j < C.N; j++)
                {
                    C.Value[i,j] = A.Value[i,j] + B.Value[i,j];
                }
            }
            return C;
        }

        private Matrix Multiple(Matrix A, Matrix B)
        {
            if (A.N != B.N)
            {
                Console.WriteLine("Matrices should have the same dimension");
                return null;
            }
            Matrix C = new Matrix(A.N);
            for (int i = 0; i < C.N; i++)
            {
                for (int j = 0; j < C.N; j++)
                {
                    C.Value[i,j] = 0;
                    for (int inner = 0; inner < C.N; inner++)
                    {
                        C.Value[i,j] = C.Value[i,j] + A.Value[i,inner] * B.Value[inner,j];
                    }
                }
            }
            return C;
        }

        private Vector Multiple(Matrix A, Vector B)
        {
            if (A.N != B.N)
            {
                Console.WriteLine("Matrix and vector should have the same dimension");
                return null;
            }
            Vector C = new Vector(A.N);
            for (int i = 0; i < C.N; i++)
            {
                C.Value[i] = 0;
                for (int j = 0; j < C.N; j++)
                {
                    C.Value[i] = C.Value[i] + A.Value[i,j] * B.Value[j];
                }
            }
            return C;
        }

        private Matrix Multiple(int A, Matrix B)
        {
            Matrix C = new Matrix(B.N);
            for (int i = 0; i < C.N; i++)
            {
                for (int j = 0; j < C.N; j++)
                {
                    C.Value[i,j] = A * B.Value[i,j];
                }
            }
            return C;
        }

        private Matrix Trans(Matrix A)
        {
            Matrix B = new Matrix(A.N);
            for (int i = 0; i < A.N; i++)
            {
                for (int j = 0; j < A.N; j++)
                {
                    B.Value[i,j] = A.Value[j,i];
                }
            }
            return B;
        }
    }
}

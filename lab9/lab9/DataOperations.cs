using System;

namespace lab9
{
   class DataOperations
    {
        int n;
        public DataOperations(int n) {
            this.n = n;
        }

        public Matrix Multiple(Matrix MA, Matrix MB, int from, int to, int n)
        {
            Matrix MC = new Matrix(n);
            for (int i = 0; i < n; i++)
            {
                for (int j = from; j < to; j++)
                {
                    MC.setValue(i,j,0);
                    for (int k = 0; k < n; k++)
                    {
                        MC.setValue(i, j, MA.getValue(i,k) * MB.getValue(i,j) + MC.getValue(i,j));
                    }
                }
            }
            return MC;
        }

       public Vector Multiple(Vector A, Matrix MB, int from, int to, int n)
        {
            Vector C = new Vector(n);
            for (int j = from; j < to; j++)
            {
                C.setValue(j, 0);
                for (int k = 0; k < n; k++)
                {
                    C.setValue(j, A.getValue(k) * MB.getValue(k,j)+C.getValue(j));
                }
            }
            return C;
        }

       public Vector Multiple(int a, Vector B, int from, int to, int n)
        {
            Vector C = new Vector(n);
            for (int j = from; j < to; j++)
            {
                C.setValue(j, B.getValue(j)*a);
            }
            return C;
        }

       public Vector Amount(Vector A, Vector B, int from, int to, int n)
        {
            Vector C = new Vector(n);
            for (int j = from; j < to; j++)
            {
                C.setValue(j, A.getValue(j)+B.getValue(j));
            }
            return C;
        }

       public Vector Sort(Vector A, int from, int to)
        {
            for (int i = from; i <= to; i++)
            {
                for (int j = from; j <= to - i; j++)
                {
                    if (A.getValue(j) < A.getValue(j+1))
                    {
                        int temp = A.getValue(j);
                        A.setValue(j, A.getValue(j + 1));
                        A.setValue(j+1, temp);
                    }
                }
            }
            return A;
        }

       public Vector MergeSort(Vector A, int from, int to)
        {
            /*for (int i = from + 1; i < to; i *= 2)
            {
                for (int j = from; j < to - 1; j += 2 * i)
                {
                    int min = std::min(j + 2 * i, to);
                    assign(A, merge(A, j, j + i, min), j, min);
                }
            }*/

            if (from + 1 >= to)
                return A;
            int mid = (from + to) / 2;
            MergeSort(A, from, mid);
            MergeSort(A, mid, to);
            Merge(A, from, mid, to);
            return A;
        }
        public Vector Merge(Vector A, int left, int mid, int right)
        {
            int i1 = 0;
            int i2 = 0;
            Vector result = new Vector(right - left);
            for (int i = 0; i < right - left; i++)
            {
                result.setValue(i,-1);
            }

            while (left + i1 < mid && mid + i2 < right)
            {
                if (A.getValue(left + i1) < A.getValue(mid + i2))
                {
                    result.setValue(i1 + i2,A.getValue(left + i1));
                    i1++;
                }
                else
                {
                    result.setValue(i1 + i2, A.getValue(mid+i2));
                    i2++;
                }
            }

            while (left + i1 < mid)
            {
                result.setValue(i1 + i2, A.getValue(left + i1));
                i1++;
            }
            while (mid + i2 < right)
            {
                result.setValue(i1 + i2, A.getValue(mid + i2));
                i2++;
            }
            for (int i = 0; i < i1 + i2; i++)
            {
                A.setValue(left + i, result.getValue(i));
            }
            return A;
        }

        public void Assign(Vector A, Vector B, int from, int to)
        {
            for (int i = from; i < to; i++)
            {
                A.setValue(i,B.getValue(i));
            }
        }
    }
}
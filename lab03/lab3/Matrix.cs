using System;

namespace lab3
{
    class Matrix
    {
        int n = 0;
        private int[,] value = null;
        public int[,] Value { get => value; set => this.value = value; }
        public int N { get => n; set => n = value; }

        public Matrix(int N)
        {
            this.N = N;
            value = new int[N,N];
            this.Generate();
        }

        private void Generate()
        {
            if (value == null) return;
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    value[i,j] = 1;
                }
            }
        }

        public void Output()
        {
            if (value == null) return;
            for (int i = 0; i < N; i++)
            {
                for (int j = 0; j < N; j++)
                {
                    Console.Write(value[i,j].ToString() + "\t");
                }
                Console.WriteLine();
            }
    
        }

    }
}

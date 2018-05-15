using System;

namespace lab9
{
    class Matrix
    {
        private int n = 0;
        private int[,] value = null;
        //public int[,] Value { get => value; set => this.value = value; }
        //public int N { get => n; set => n = value; }

        public int getN()
        {
            return this.n;
        }

        public void setN(int n)
        {
            this.n = n;
        }

        public int[,] getValue()
        {
            return this.value;
        }

        public int getValue(int i, int j)
        {
            return this.value[i,j];
        }


        public void setValue(int[,] value)
        {
            this.value = value;
        }

        public void setValue(int i, int j, int value)
        {
            this.value[i,j] = value;
        }
        

        public Matrix(int n)
        {
            this.n = n;
            value = new int[n, n];
            //this.Generate();
        }
        

        public void Generate()
        {
            if (value == null) return;
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    value[i, j] = 1;
                }
            }
        }

        public void Output()
        {
            if (value == null) return;
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    Console.Write(value[i, j].ToString() + "\t");
                }
                Console.WriteLine();
            }

        }

    }
}
using System;

namespace lab3
{
    class Vector
    {
        public int n = 0;
        public int[] value = null;
        public int[] Value { get => value; set => this.value = value; }
        public int N { get => n; set => n = value; }

        public Vector(int N)
        {
            this.N = N;
            value = new int[N];
            this.Generate();
        }
        private void Generate()
        {
            if (value == null) return;
            for (var i = 0; i < N; i++)
            {
                value[i] = 1;
            }
        }

        public void Output()
        {
            if (value == null) return;
            for (var i = 0; i < N; i++)
            {
                Console.Write(value[i].ToString() + "\t");
            }
            Console.WriteLine();

        }
    }
}

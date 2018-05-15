using System;

namespace lab9
{
    class Vector
    {
        private int n = 0;
        private int[] value = null;
        //public int[] Value { get => value; set => this.value = value; }
        //public int n { get => n; set => n = value; }

        public int getn() {
            return n;
        }

        public void setn(int n) {
            this.n = n;
        }

        public int[] getValue() {
            return value;
        }

        public int getValue(int i)
        {
            return value[i];
        }

        public void setValue(int[] value) {
            this.value = value;
        }

        public void setValue(int i, int value)
        {
            this.value[i] = value;
        }
        

        public Vector(int n)
        {
            this.n = n;
            value = new int[n];
            //this.Generate();
        }
        public void Generate()
        {
            if (value == null) return;
            for (var i = 0; i < n; i++)
            {
                value[i] = 1;
            }
        }

        public void Output()
        {
            if (value == null) return;
            for (var i = 0; i < n; i++)
            {
                Console.Write(value[i].ToString() + "\t");
            }
            Console.WriteLine();

        }
    }
}
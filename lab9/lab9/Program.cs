
using System;

namespace lab9
{
    class Program
    {
      static void Main(string[] args)
        {
            Console.WriteLine("started Main");
            Threads threads = new Threads();
            threads.Run();
            Console.WriteLine("finished Main");
        }
    }
}

using System;
using System.Threading;

namespace lab3
{
    class Program
    {
        static int N = 0;
        static Semaphore sem = new Semaphore(1, 1);

        static void Main(string[] args)
        {
            Console.WriteLine("Main started");

            Int32.TryParse(Console.ReadLine(),out N);
            Thread T1 = new Thread(FunctionForT1);
            Thread T2 = new Thread(FunctionForT2);
            Thread T3 = new Thread(FunctionForT3);

            T1.Priority = ThreadPriority.Lowest;
            T2.Priority = ThreadPriority.Normal;
            T3.Priority = ThreadPriority.Highest;

            T1.Start();
            T2.Start();
            T3.Start();

            T1.Join();
            T2.Join();
            T3.Join();
            Console.WriteLine("Main finished");

            Console.ReadKey();

        }

        static void FunctionForT1()
        {
            sem.WaitOne();
            Console.WriteLine("Thread #1 started");
            sem.Release();
            Data Manager = new Data();
            Matrix A = new Matrix(N);
            Matrix D = new Matrix(N);
            Vector B = new Vector(N);
            Matrix E = Manager.F1(A,D,B);
            sem.WaitOne();
            Console.WriteLine("Matrix E (thread #1):");
            E.Output();
            Console.WriteLine("Thread #1 finished");
            sem.Release();

        }
        static void FunctionForT2()
        {
            sem.WaitOne();
            Console.WriteLine("Thread #2 started");
            sem.Release();
            Data Manager = new Data();
            Matrix G = new Matrix(N);
            Matrix K = new Matrix(N);
            Matrix L = new Matrix(N);
            Matrix F = Manager.F2(5, G, K, L);
            sem.WaitOne();
            Console.WriteLine("Matrix F (thread #2):");
            F.Output();
            Console.WriteLine("Thread #2 finished");
            sem.Release();


        }
        static void FunctionForT3()
        {
            sem.WaitOne();
            Console.WriteLine("Thread #3 started");
            sem.Release();
            Data Manager = new Data();
            Matrix P = new Matrix(N);
            Matrix R = new Matrix(N);
            Vector S = new Vector(N);
            Vector T = new Vector(N);
            Vector O = Manager.F3(P, R, S, T);
            sem.WaitOne();
            Console.WriteLine("Vector O (thread #3):");
            O.Output();
            Console.WriteLine("Thread #3 finished");
            sem.Release();

        }
    }
}

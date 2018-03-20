using System;
using System.Threading;

namespace lab9
{
    class Threads
    {
        const int N = 6;
        const int P = 6;
        const int H = N / P;

        int d, x;
        Vector A = new Vector(N);
        Vector E = new Vector(N);
        Vector S = new Vector(N);
        Matrix MO = new Matrix(N);
        Matrix MK = new Matrix(N);

        private ManualResetEvent[] EventInput;
        private AutoResetEvent[] EventMerge;
        private Mutex MutexCopy;
        private Semaphore[] SemCalc;
        private Semaphore SemCopy;
        private object CrSecCopy;        public void Run()
        {
            CrSecCopy = new object();
            EventInput = new[] {
                new ManualResetEvent(false),
                new ManualResetEvent(false),
                new ManualResetEvent(false)
            };
            EventMerge = new[] {
                new AutoResetEvent(false),
                new AutoResetEvent(false)
            };
            MutexCopy = new Mutex();
            SemCopy = new Semaphore(1, 1);
            SemCalc = new[]
            {
                new Semaphore(0, 1),
                new Semaphore(0, 1),
                new Semaphore(0, 1)
            };


            var threads = new[]
                {
                new Thread(T1),
                new Thread(T2),
                new Thread(T3),
                new Thread(T4),
                new Thread(T5),
                new Thread(T6)
                };
            foreach (var t in threads)
            {
                t.Start();
            }
            foreach (var t in threads)
            {
                t.Join();
            }
            Console.Read();
        }

        void T1()
        {
            Console.WriteLine("started T1");
            DataOperations data = new DataOperations(N);
            int from = 0;
            int to = H;

            int d1, x1;
            Vector S1 = new Vector(N);
            Matrix MO1 = new Matrix(N);

            //1.Ввод МК, Е
            MK.Generate();
            E.Generate();

            //2.Сигнал о вводе МК, Е
            EventInput[0].Set();

            //3.Ждать сигнал об окончании ввода от Т2..Т6
            WaitHandle.WaitAll(EventInput);

            //4.Копирование d
            SemCopy.WaitOne();
            d1 = d;
            SemCopy.Release();

            //5.Копирование x
            MutexCopy.WaitOne();
            x1 = x;
            MutexCopy.ReleaseMutex();

            //6.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S1.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO1.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //7.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d1, E, from, to, N), data.Multiple(S1, data.Multiple(MO1, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

  
            //8.Ждать сигнала об окончании вычислений в Т2
            SemCalc[0].WaitOne();

            //9.Сортировка силянием : A2h = sort*(Ah,Ah)
            data.Assign(A, data.MergeSort(A, 0, 2 * H), 0, 2 * H);
           
            //10.Ждать сигнал об окончании сортировок слияниев в Т3 и Т5
            WaitHandle.WaitAll(EventMerge);
           
            //11.Сортировка слиянием : A = sort*(A2h,A2h,A2h)
            data.Assign(A, data.MergeSort(A, 0, N), 0, N);

            //12.Вывод результата
            if (N <= 100) A.Output();
            Console.WriteLine("finished T1");

        }

        void T2()
        {
            Console.WriteLine("started T2");
            DataOperations data = new DataOperations(N);
            int from = H;
            int to = 2 * H;

            int d2, x2;
            Vector S2 = new Vector(N);
            Matrix MO2 = new Matrix(N);


            //1.Ждать сигнал об окончании ввода от Т1,T3..Т6
            WaitHandle.WaitAll(EventInput);

            //2.Копирование d
            SemCopy.WaitOne();
            d2 = d;
            SemCopy.Release();

            //3.Копирование x
            MutexCopy.WaitOne();
            x2 = x;
            MutexCopy.ReleaseMutex();

            //4.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S2.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO2.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //5.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d2, E, from, to, N), data.Multiple(S2, data.Multiple(MO2, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);


            //6.Сигнал Т1 об окончании вычислений
            SemCalc[0].Release();
            Console.WriteLine("finished T2");

        }

        void T3()
        {
            Console.WriteLine("started T3");
            DataOperations data = new DataOperations(N);
            int from = 2 * H;
            int to = 3 * H;

            int d3, x3;
            Vector S3 = new Vector(N);
            Matrix MO3 = new Matrix(N);

            //1.Ввод d, S
            d = 1;
            S.Generate();

            //2.Сигнал о вводе d, S
            EventInput[1].Set();

            //3.Ждать сигнал об окончании ввода от Т1,T2,T4..Т6
            WaitHandle.WaitAll(EventInput);

            //4.Копирование d
            SemCopy.WaitOne();
            d3 = d;
            SemCopy.Release();

            //5.Копирование x
            MutexCopy.WaitOne();
            x3 = x;
            MutexCopy.ReleaseMutex();

            //6.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S3.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO3.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //7.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d3, E, from, to, N), data.Multiple(S3, data.Multiple(MO3, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

            //8.Ждать сигнала об окончании вычислений в Т4
            SemCalc[1].WaitOne();

            //9.Сортировка силянием : A2h = sort*(Ah,Ah)
            data.Assign(A, data.MergeSort(A, 2 * H, 4 * H), 2 * H, 4 * H);

            //10.Сигнал Т1 об окончании сортировки
            EventMerge[1].Set();

            Console.WriteLine("finished T3");
        }
        void T4()
        {
            Console.WriteLine("started T4");
            DataOperations data = new DataOperations(N);
            int from = 3 * H;
            int to = 4 * H;

            int d4, x4;
            Vector S4 = new Vector(N);
            Matrix MO4 = new Matrix(N);

            //1.Ввод x, MO
            x = 1;
            MO.Generate();

            //2.Сигнал о вводе x, MO
            EventInput[2].Set();

            //3.Ждать сигнал об окончании ввода от Т1..T3,T5,Т6
            WaitHandle.WaitAll(EventInput);

            //4.Копирование d
            SemCopy.WaitOne();
            d4 = d;
            SemCopy.Release();

            //5.Копирование x
            MutexCopy.WaitOne();
            x4 = x;
            MutexCopy.ReleaseMutex();

            //6.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S4.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO4.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //7.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d4, E, from, to, N), data.Multiple(S4, data.Multiple(MO4, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

            //8.Сигнал Т3 об окончании вычислений
            SemCalc[1].Release();
            Console.WriteLine("finished T4");
        }

        void T5()
        {
            Console.WriteLine("started T5");
            DataOperations data = new DataOperations(N);
            int from = 4 * H;
            int to = 5 * H;

            int d5, x5;
            Vector S5 = new Vector(N);
            Matrix MO5 = new Matrix(N);

            //1.Ждать сигнал об окончании ввода от Т1..T4,Т6
            WaitHandle.WaitAll(EventInput);

            //2.Копирование d
            SemCopy.WaitOne();
            d5 = d;
            SemCopy.Release();

            //3.Копирование x
            MutexCopy.WaitOne();
            x5 = x;
            MutexCopy.ReleaseMutex();

            //4.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S5.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO5.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //5.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d5, E, from, to, N), data.Multiple(S5, data.Multiple(MO5, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

            //6.Ждать сигнал от T6 об окончании вычислений
            SemCalc[2].WaitOne();

            //7.Сортировка силянием : A2h = sort*(Ah,Ah)
            data.Assign(A, data.MergeSort(A, 4 * H, N), 4 * H, N);
              
            //8.Сигнал Т1 об окончании сортировки
            EventMerge[0].Set();
            Console.WriteLine("finished T5");

        }

        void T6()
        {
            Console.WriteLine("started T6");
            DataOperations data = new DataOperations(N);
            int from = 5 * H;
            int to = N;

            int d6, x6;
            Vector S6 = new Vector(N);
            Matrix MO6 = new Matrix(N);

            //1.Ждать сигнал об окончании ввода от Т1..T5
            WaitHandle.WaitAll(EventInput);

            //2.Копирование d
            SemCopy.WaitOne();
            d6 = d;
            SemCopy.Release();

            //5.Копирование x
            MutexCopy.WaitOne();
            x6 = x;
            MutexCopy.ReleaseMutex();

            //6.Копирование MO,S
            lock (CrSecCopy)
            {
                for (int i = 0; i < N; i++)
                {
                    S6.setValue(i, S.getValue(i));
                    for (int j = 0; j < N; j++)
                    {
                        MO6.setValue(i, j, MO.getValue(i, j));
                    }
                }
            }

            //7.Вычисление
            data.Assign(A, data.Sort(data.Amount(data.Multiple(d6, E, from, to, N), data.Multiple(S6, data.Multiple(MO6, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

            //8.Сигнал Т5 об окончании вычислений
            SemCalc[2].Release();
           
            Console.WriteLine("finished T6");
        }
    }
}

package edu.kpi.pp;

import edu.kpi.pp.monitores.ResourceMonitor;
import edu.kpi.pp.monitores.SynchronizationMonitor;

import java.util.Arrays;


public class Main {

    public static int P = 6;
    public static int N = 12;
    private static int H = N / P;

    static int[] A = new int[N];
    static int[] B = new int[N];
    static int[] C = new int[N];
    static int[] Z = new int[N];
    static int[] S = new int[N];
    static int[][] MO = new int[N][N];


    private static ResourceMonitor rm = new ResourceMonitor();
    private static SynchronizationMonitor sm = new SynchronizationMonitor();

    public static void main(String[] args) {

        AThread T1 = new AThread("T1", 0, H, true) {
            @Override
            void input() {
                //Enter B, S
                fillVector(B, 1);
                fillVector(S, 1);

                // Signal B, S input
                sm.signal1();
            }
        };

        AThread T2 = new AThread("T2", H, 2 * H, false) {
            @Override
            void input() {
                // Input C, MK
                fillVector(C, 1);

                int[][] MK2 = new int[N][N];
                fillMatrix(MK2, 1);
                rm.inputMK(MK2);

                // Signal C, MK input
                sm.signal1();
            }
        };

        AThread T3 = new AThread("T3", 2 * H, 3 * H, false) {
            @Override
            void input() {
                // Input Z, S
                fillVector(Z, 1);
                fillVector(S, 1);

                // Signal Z, S input
                sm.signal1();
            }
        };

        AThread T4 = new AThread("T4", 3 * H, 4 * H, false) {
            @Override
            void input() {
                // Input MO, d
                fillMatrix(MO, 1);
                rm.inputD(1);

                // Signal MO, d input
                sm.signal1();
            }
        };

        AThread T5 = new AThread("T5", 4 * H, 5 * H, false) {
            @Override
            void input() {
            }
        };

        AThread T6 = new AThread("T6", 5 * H, N, false) {
            @Override
            void input() {
            }
        };

        Runnable[] tasks = new Runnable[]{T1, T2, T3, T4, T5, T6};

        Thread[] threads = new Thread[P];
        for (int i = 0; i < P; i++) {
            threads[i] = new Thread(tasks[i]);
            threads[i].start();
        }

        for (Thread t : threads) {
            try {
                t.join();
            } catch (InterruptedException ignored) {
            }
        }
    }

    abstract static class AThread implements Runnable {
        String name;
        int from, to;
        boolean output;

        private int e, d, current;
        private int[][] MK = new int[N][N];

        AThread(String name, int from, int to, boolean output) {
            this.name = name;
            this.from = from;
            this.to = to;
            this.output = output;
        }

        abstract void input();

        public void run() {
            System.out.println(name + " started");

            //Input values
            input();

            // Wait for input
            sm.wait1();

            // Calculate ei = (BH * CH)
            current = calculateSubDot(from, to, B, C);
            // Calculate e = e + ei
            rm.addE(current);

            // Signal e calculation finish
            sm.signal2();

            // Wait other threads to finish m calculation
            sm.wait2();

            //Copy e, d, MK
            e = rm.copyE();
            d = rm.copyD();
            MK = rm.copyMK();

            // Calculate AH = ei * ZH + di * SH * (MOH * MKi)
            calculateA(from, to, e, d, MK);

            if (output) {
                // Wait for other threads to finish
                sm.wait3();
                // Print A
                if (N <= 12) {
                    System.out.println(Arrays.toString(A));
                }
            } else
                sm.signal3();

            System.out.println(name + " finished");
        }

        private int calculateSubDot(int from, int to, int[] b, int[] c) {
            int result = 0;
            for (int i = from; i < to; i++) {
                result += B[i] * C[i];
            }
            return result;
        }

        void fillMatrix(int[][] matrix, int value) {
            for (int[] row : matrix) {
                fillVector(row, value);
            }
        }

        void fillVector(int[] vector, int value) {
            for (int i = 0; i < vector.length; i++) {
                vector[i] = value;
            }
        }

        private void calculateA(int from, int to, int ei, int di, int[][] MKi) {
            int[] V = new int[N];
            int current;
            for (int i = from; i < to; i++) {
                for (int j = 0; j < N; j++) {
                    V[j] = 0;
                    current = 0;
                    for (int k = 0; k < N; k++) {
                        current += MO[i][k] * MKi[k][j];
                    }
                    for (int k = 0; k < N; k++) {
                        V[j] += current * S[k];
                    }
                }
                A[i] = ei * Z[i] + di * V[i];
            }
        }
    }
}


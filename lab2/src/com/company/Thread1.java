package com.company;

public class Thread1 extends Thread {
    int N = 0;

    Thread1(int N) {
        this.N = N;
        System.out.println("Thread #1 has started");
    }

    @Override
    public void run() {
        Matrix A = new Matrix(N);
        Matrix D = new Matrix(N);
        Vector B = new Vector(N);
        Data manager = new Data();
        Matrix E = manager.F1(A, D, B);
        System.out.println("Matrix E (thread #1):");
        E.Output();
        System.out.println("Thread #1 has finished");
    }
}

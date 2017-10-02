package com.company;

public class Thread3 extends Thread {
    int N = 0;

    Thread3(int N) {
        this.N = N;
        System.out.println("Thread #3 has started");
    }

    @Override
    public void run() {
        Matrix P = new Matrix(N);
        Matrix R = new Matrix(N);
        Vector S = new Vector(N);
        Vector T = new Vector(N);
        Data manager = new Data();
        Vector O = manager.F3(P, R, S, T);
        System.out.println("Vector O (thread #3):");
        O.Output();
        System.out.println("Thread #3 has finished");
    }
}

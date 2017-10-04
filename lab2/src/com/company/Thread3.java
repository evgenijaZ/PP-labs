package com.company;

import java.util.concurrent.Semaphore;

public class Thread3 extends Thread {
    int N = 0;
    private Semaphore sem;
    Thread3(int N, Semaphore s) {
        this.sem = s;
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
        try {
            sem.acquire();
            O.Output();
        } catch (InterruptedException ex){
            System.out.printf("Thread %s is interrupted", this.getName());
        }
        sem.release();
        System.out.println("Thread #3 has finished");
    }
}

package com.company;

import java.util.concurrent.Semaphore;

public class Thread1 extends Thread {
    int N = 0;
    private Semaphore sem;
    Thread1(int N, Semaphore s) {
        this.sem = s;
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
        try {
            sem.acquire();
            E.Output();
        } catch (InterruptedException ex){
            System.out.printf("Thread %s is interrupted", this.getName());
        }
        sem.release();
        System.out.println("Thread #1 has finished");
    }
}

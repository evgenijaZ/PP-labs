package com.company;

import java.util.concurrent.Semaphore;

public class Thread2 extends Thread {
    int N = 0;
    private Semaphore sem;
    Thread2(int N, Semaphore s){
        this.sem = s;
        this.N = N;
        System.out.println("Thread #2 has started");
    }

    @Override
    public void run(){
        Matrix G = new Matrix(N);
        Matrix K = new Matrix(N);
        Matrix L = new Matrix(N);
        Data manager = new Data();
        Matrix F = manager.F2(5,G,K,L);
        System.out.println("Matrix F (thread #2):");
        try {
            sem.acquire();
            F.Output();
        } catch (InterruptedException ex){
            System.out.printf("Thread %s is interrupted", this.getName());
        }
        sem.release();
        System.out.println("Thread #2 has finished");
    }
}

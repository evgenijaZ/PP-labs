package com.company;

public class Thread2 extends Thread {
    int N = 0;

    Thread2(int N){
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
        F.Output();
        System.out.println("Thread #2 has finished");
    }
}

package com.company;

import java.util.Scanner;
import java.util.concurrent.Semaphore;

public class Main {

    public static void main(String[] args) {
        Semaphore s = new Semaphore(1);
        System.out.println("Main thread has started");
        System.out.println("Enter N1, N2, N3:");
        Scanner in = new Scanner(System.in);
        int N1 = in.nextInt(),N2 = in.nextInt(),N3 = in.nextInt();
        Thread1 t1 = new Thread1(N1,s);
        Thread2 t2 = new Thread2(N2,s);
        Thread3 t3 = new Thread3(N3,s);
        t1.setPriority(10);
        t2.setPriority(5);
        t3.setPriority(1);
        t1.start();
        t2.start();
        t3.start();
        try{
            t1.join();
            t2.join();
            t3.join();
        }
        catch(InterruptedException e){
            System.out.printf("Thread is interrupted");
            e.printStackTrace();
        }
        System.out.println("Main thread has finished");
    }
}

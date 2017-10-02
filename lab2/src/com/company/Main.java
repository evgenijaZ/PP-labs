package com.company;

import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
        System.out.println("Main thread has started");
        System.out.println("Enter N1, N2, N3:");
        Scanner in = new Scanner(System.in);
        int N1 = in.nextInt(),N2 = in.nextInt(),N3 = in.nextInt();
        Thread1 t1 = new Thread1(N1);
        Thread2 t2 = new Thread2(N2);
        Thread3 t3 = new Thread3(N3);
        t1.setPriority(10);
        t2.setPriority(5);
        t3.setPriority(1);
        t1.start();
        try {
            t1.join();
        } catch (InterruptedException e) {
            System.out.printf("Thread %s is interrupted", t1.getName());
        }

        t2.start();
        try {
            t2.join();
        } catch (InterruptedException e) {
            System.out.printf("Thread %s is interrupted", t2.getName());
        }

        t3.start();
        try{
            t3.join();
        }
        catch(InterruptedException e){
            System.out.printf("Thread %s is interrupted", t3.getName());
        }
        System.out.println("Main thread has finished");
    }
}

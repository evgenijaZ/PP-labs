package edu.kpi.pp.monitores;

import edu.kpi.pp.Main;

public class ResourceMonitor {
    private int e = 0;
    private int d;
    private int[][] MK;

    private final Object M1 = new Object();
    private final Object M2 = new Object();
    private final Object M3 = new Object();

    public void addE(int current) {
        e+=current;
    }

    public int copyE() {
       synchronized (M1){
           return e;
       }
    }

    public void inputD(int value){
        synchronized (M2){
            this.d = value;
        }
    }

    public int copyD() {
        synchronized (M2){
            return d;
        }
    }

    public void inputMK(int[][] value) {
        synchronized (M3) {
            this.MK = value;
        }
    }

    public int[][] copyMK() {
        synchronized (M3) {
            int[][] copy = new int[Main.N][Main.N];
            for (int i = 0; i < Main.N; ++i) {
                System.arraycopy(this.MK[i], 0, copy[i], 0, Main.N);
            }
            return copy;
        }
    }
}

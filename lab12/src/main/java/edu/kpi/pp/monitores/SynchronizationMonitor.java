package edu.kpi.pp.monitores;

import edu.kpi.pp.Main;

public class SynchronizationMonitor {
    private int F1 = 0;
    private int F2 = 0;
    private int F3 = 0;

    public synchronized void signal1() {
        F1++;
        if (F1 == 4) {
            notifyAll();
        }
    }

    public synchronized void signal2() {
        F2++;
        if (F2 == Main.P) {
            notifyAll();
        }
    }

    public synchronized void signal3() {
        F3++;
        if (F3 == Main.P - 1) {
            notifyAll();
        }
    }

    public synchronized void wait1() {
        if (F1 != 4) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public synchronized void wait2() {
        if (F2 != Main.P) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }

    public synchronized void wait3() {
        if (F3 != Main.P - 1) {
            try {
                wait();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}


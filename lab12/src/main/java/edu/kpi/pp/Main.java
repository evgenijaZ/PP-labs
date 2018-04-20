package edu.kpi.pp;

import edu.kpi.pp.monitores.ResourceMonitor;
import edu.kpi.pp.monitores.SynchronizationMonitor;

import java.util.Arrays;


public class Main {

    public static int P = 6;
    public static int N = 12;
    private static int H = N / P;

    static int[] A = new int[N];
    static int[] B = new int[N];
    static int[] C = new int[N];
    static int[] Z = new int[N];
    static int[] S = new int[N];
    static int[][] MO = new int[N][N];


    private static ResourceMonitor rm = new ResourceMonitor();
    private static SynchronizationMonitor sm = new SynchronizationMonitor();

    public static void main(String[] args) {

    }
}


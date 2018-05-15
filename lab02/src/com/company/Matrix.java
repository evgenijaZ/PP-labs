package com.company;

class Matrix {
    int[][] value = null;

    Matrix(int N) {
        value = new int[N][N];
        this.Generate();
    }

    private void Generate() {
        if (value == null) return;
        for (int i = 0; i < value.length; i++) {
            for (int j = 0; j < value[i].length; j++) {
                value[i][j] = 1;
            }
        }
    }

    void Output() {
        if (value == null) return;
        synchronized (this) {
            for (int[] aValue : value) {
                for (int anAValue : aValue) {
                    System.out.print(anAValue + "\t");
                }
                System.out.println();
            }
        }
    }

}

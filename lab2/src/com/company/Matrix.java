package com.company;

class Matrix {
    int[][] value = null;
    Matrix (int N){
        value = new int[N][N];
    }

    int[][] Generate (){
        if(value == null) return null;
        for (int i = 0; i<value.length; i++){
            for (int j = 0; j<value[i].length; j++) {
                value[i][j] = 1;
            }
        }
        return value;
    }

    void Output (){
        if(value == null) return;
        for (int[] aValue : value) {
            for (int anAValue : aValue) {
                System.out.print(anAValue + "\t");
            }
            System.out.println();
        }
    }

}

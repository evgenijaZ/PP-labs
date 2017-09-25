package com.company;

class Vector {
    int[] value = null;
    private int N = 0;
    Vector(int N){
        this.N = N;
        value = new int[N];
    }

    int[] Generate (){
        if(value == null) return null;
        for (int i = 0; i<value.length; i++){
                value[i] = 1;
            }
        return value;
    }

    void Output (){
        if(value == null) return;
        for (int i = 0; i<value.length; i++){
                System.out.print(value[i]+"\t");
            System.out.println();
        }
    }

}

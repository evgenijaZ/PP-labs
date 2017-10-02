package com.company;

class Vector {
    int[] value = null;
    Vector(int N){
        value = new int[N];
        this.Generate();
    }

    private void Generate(){
        if(value == null) return;
        for (int i = 0; i<value.length; i++) {
            value[i] = 1;
        }
    }

    void Output (){
        if(value == null) return;
        for (int aValue : value) {
            System.out.print(aValue + "\t");
        }
        System.out.println();
    }

}

package com.company;

import java.util.ArrayList;
import java.util.List;

public class Data {

    Matrix F1(Matrix A, Matrix D, Vector B){
        Matrix E = Multiple(Max(B),Multiple(A,D));
        return E;
    }

    Matrix F2 (int A, Matrix G, Matrix K, Matrix L){
         Matrix F = new Matrix(G.value.length);
         F = Amount(Multiple(A, Trans(G)),Multiple(K,L));
         return F;
    }

    Vector F3 (Matrix P, Matrix R, Vector S, Vector T){
        Vector O = new Vector(P.value.length);
        O = Amount(Multiple(Multiple(P,R),S),T);
        return O;
    }


    private int Max(Vector A){
        int maxItem = A.value[0];
        for (int aValue : A.value)
            if (aValue > maxItem) maxItem = aValue;
        return maxItem;
    }

    private Vector Amount(Vector A, Vector B){
        if(A.value.length!=B.value.length){
            System.out.println("Vectors should have the same length");
            return null;
        }
        Vector C = new Vector(A.value.length);
        for (int i = 0; i<C.value.length; i++){
            C.value[i] = A.value[i]+B.value[i];
        }
        return C;
    }

    private Matrix Amount(Matrix A, Matrix B){
        if(A.value.length!=B.value.length || A.value[0].length!=B.value[0].length){
            System.out.println("Matrices should have the same dimension");
            return null;
        }
        Matrix C = new Matrix(A.value.length);
        for (int i = 0; i<C.value.length; i++){
            for (int j = 0; j<C.value[i].length; j++) {
                C.value[i][j] = A.value[i][j] + B.value[i][j];
            }
        }
        return C;
    }

    private Matrix Multiple(Matrix A, Matrix B){
        if(A.value.length!=B.value.length || A.value[0].length!=B.value[0].length){
            System.out.println("Matrices should have the same dimension");
            return null;
        }
        Matrix C = new Matrix(A.value.length);
        for (int i = 0; i<C.value.length; i++){
            for (int j = 0; j<C.value[i].length; j++) {
                C.value[i][j] = 0;
                for (int inner = 0; inner < C.value[i].length; inner++){
                    C.value[i][j] = C.value[i][j]+ A.value[i][inner]*B.value[inner][j];
                }
            }
        }
        return C;
    }

    private Vector Multiple(Matrix A, Vector B){
        if(A.value.length!=B.value.length){
            System.out.println("Matrix and vector should have the same dimension");
            return null;
        }
        Vector C = new Vector(A.value.length);
        for (int i = 0; i<C.value.length; i++){
            C.value[i] = 0;
            for (int j = 0; j<C.value.length; j++) {
                    C.value[i] = C.value[i]+ A.value[i][j]*B.value[j];
            }
        }
        return C;
    }

    private Matrix Multiple(int A, Matrix B){
        Matrix C = new Matrix(B.value.length);
        for (int i = 0; i<C.value.length; i++){
            for (int j = 0; j<C.value[i].length; j++) {
                    C.value[i][j] = A*B.value[i][j];
            }
        }
        return C;
    }

    private Matrix Trans(Matrix A){
        Matrix B = new Matrix(A.value.length);
        for (int i = 0; i<A.value.length; i++){
            for (int j = 0; j<A.value[i].length; j++) {
                B.value[i][j]=A.value[j][i];
            }
        }
        return B;
    }

}

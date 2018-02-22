#pragma once
typedef int* vector;
typedef int** matrix;


matrix create_matrix(int n);

void fill_with_one(vector A, int n);
void fill_with_one(matrix MA, int n);

void output(vector A, int n);
void output(matrix MA, int n);


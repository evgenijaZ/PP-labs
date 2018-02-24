#pragma once
typedef int* vector;
typedef int** matrix;


matrix create_matrix(int n);

void fill_with_one(vector A, int n);
void fill_with_one(matrix MA, int n);

void output(vector A, int n);
void output(matrix MA, int n);

matrix multiple(matrix MA, matrix MB, int from, int to, int n);
vector multiple(vector A, matrix MB, int from, int to, int n);
vector multiple(int a, vector B, int from, int to, int n);
vector amount(vector A, vector B, int from, int to, int n);

vector sort(vector A, int from, int to);

#include "stdafx.h";
#include "omp.h";
#include <iostream>;
typedef int* vector;
typedef int** matrix;

matrix create_matrix(int n)
{
	matrix MA = new vector[n];
	for (int i = 0; i < n; i++) {
		MA[i] = new int[n];
	}
	return MA;
}

void fill_with_one(vector A, int n)
{
	for (int i = 0; i < n; i++) {
		A[i] = 1;
	}
}

void fill_with_one(matrix MA, int n)
{
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			MA[i][j] = 1;
		}
	}
}

void output(vector A, int n)
{
	for (int i = 0; i < n; i++) {
		printf("%d ", A[i]);
	}
	printf("\n");
}

void output(matrix MA, int n)
{
	for (int i = 0; i < n; i++) {
		for (int j = 0; j < n; j++) {
			printf(" %d", MA[i][j]);
		}
		printf("\n");
	}
}

void copy(matrix MA, matrix MB, int N)
{
	for (int i = 0; i < N; i++) {
		for (int j = 0; j < N; j++) {
			MB[i][j] = MA[i][j];
		}
	}
}

int min(int a, int b) { return a < b ? a : b; }

int max(int a, int b) { return a > b ? a : b; }

const int N = 10;
const int P = 6;
const int H = N / P;
vector Z = new int[N];
vector S = new int[N];
matrix MA = create_matrix(N);
matrix MO = create_matrix(N);
matrix MF = create_matrix(N);
matrix MT = create_matrix(N);
int a = INT16_MIN;
int b = INT16_MAX;

int main()
{
	printf("Main thread : started\n");
	omp_lock_t lck;
	omp_init_lock(&lck);
	omp_set_num_threads(P);
#pragma omp parallel num_threads(P) shared(a, b, MO)
	{
		int num = omp_get_thread_num() + 1;
		printf("Thread %d: started\n", num);
		switch (num) {
		case 1:
			fill_with_one(MT, N);
			break;
		case 3:
			fill_with_one(Z, N);
			fill_with_one(S, N);
			break;
		case 6:
			fill_with_one(MO, N);
			fill_with_one(MF, N);
			break;
		}
#pragma omp barrier

		// ai = max(Zh)
		int ai = INT_MIN;
#pragma omp for
		for (int i = 0; i < N; i++) {
			ai = max(ai, Z[i]);
		}
		// a=max(a,ai)
#pragma omp critical
		{
			a = max(a, ai);
		}
		// bi=min(Sh)
		int bi = INT_MAX;
#pragma omp for
		for (int i = 0; i < N; i++) {
			bi = min(bi, S[i]);
		}
		// b=min(b,bi)
#pragma omp critical
		{
			b = min(b, bi);
		}
#pragma omp barrier

		// copy
		matrix MO1 = create_matrix(N);
		int a1, b1;
#pragma omp critical(copy)
		{
			copy(MO, MO1, N);
			a1 = a, b1 = b;
		}
		// MAh = MO * MTh
#pragma omp for
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++) {
				MA[i][j] = 0;
				for (int k = 0; k < N; k++) {
					MA[i][j] += MO[i][k] * MT[k][j];
				}
			}
		}

		// a * MAh
#pragma omp for
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++) {
				MA[i][j] *= a;
			}
		}
		// MFh = b * MFh
#pragma omp for
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++) {
				MF[i][j] = b * MA[i][j];
			}
		}
		// MAh = MAh + MFh
#pragma omp for
		for (int i = 0; i < N; i++) {
			for (int j = 0; j < N; j++) {
				MA[i][j] = MA[i][j] + MF[i][j];
			}
		}
#pragma barrier
		if (num == 1) {
			if (N <= 20) {
				output(MA, N);
			}
		}
	}
	system("pause");
}

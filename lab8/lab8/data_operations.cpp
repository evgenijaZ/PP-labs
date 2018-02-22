#include "data_operations.h"

matrix create_matrix(int N)
{
	matrix MA = new vector[N];
	for (int i = 0; i < N; i++) {
		MA[i] = new int[N];
	}
	return MA;
}

void fill_with_one(vector A, int n)
{
	for (int i = 0; i < n; i++)
	{
		A[i] = 1;
	}
}

void fill_with_one(matrix MA, int n)
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			MA[i][j] = 1;
		}
	}
}

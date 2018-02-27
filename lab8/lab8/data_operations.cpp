#include "stdafx.h"
#include "data_operations.h"
#include <algorithm>    // std::swap
#include "stdio.h"

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

void output(vector A, int n)
{
	for (int i = 0; i < n; i++)
	{
		printf("%d ", A[i]);
	}
	printf("\n");
}

void output(matrix MA, int n)
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			printf(" %d", MA[i][j]);
		}
		printf("\n");
	}
}

matrix multiple(matrix MA, matrix MB, int from, int to, int n)
{
	matrix MC = create_matrix(n);
	for (int i = 0; i < n; i++)
	{
		for (int j = from; j < to; j++)
		{
			MC[i][j] = 0;
			for (int k = 0; k < n; k++)
			{
				MC[i][j] += MA[i][k] * MB[k][j];
			}
		}
	}
	return MC;
}

vector multiple(vector A, matrix MB, int from, int to, int n)
{
	vector C = new int[n];
	for (int j = from; j < to; j++)
	{
		C[j] = 0;
		for (int k = 0; k < n; k++)
		{
			C[j] += A[k] * MB[k][j];
		}
	}
	return C;
}

vector multiple(int a, vector B, int from, int to, int n)
{
	vector C = new int[n];
	for (int j = from; j < to; j++)
	{
		C[j] = B[j] * a;
	}
	return C;
}

vector amount(vector A, vector B, int from, int to, int n) {
	vector C = new int[n];
	for (int j = from; j < to; j++)
	{
		C[j] = A[j] + B[j];
	}
	return C;
}

vector sort(vector A, int from, int to) {
	for (int i = from; i <= to; i++) {
		for (int j = from; j <= to - i; j++) {
			if (A[j] < A[j + 1]) {
				std::swap(A[j], A[j + 1]);
			}
		}
	}
	return A;
}

vector merge_sort(vector A, int from, int to) {
	/*for (int i = from + 1; i < to; i *= 2)
	{
		for (int j = from; j < to - 1; j += 2 * i)
		{
			int min = std::min(j + 2 * i, to);
			assign(A, merge(A, j, j + i, min), j, min);
		}
	}*/

	if (from + 1 >= to)
		return A;
	int mid = (from + to) / 2;
	merge_sort(A, from, mid);
	merge_sort(A, mid, to);
	merge(A, from, mid, to);

	return A;
}
vector merge(vector A, int left, int mid, int right) {
	int i1 = 0;
	int i2 = 0;
	vector result = new int[right - left];
	for (int i = 0; i < right - left; i++)
	{
		result[i] = -1;
	}

	while (left + i1 < mid && mid + i2 < right)
	{
		if (A[left + i1] < A[mid + i2]) {
			result[i1 + i2] = A[left + i1];
			i1++;
		}
		else {
			result[i1 + i2] = A[mid + i2];
			i2++;
		}
	}

	while (left + i1 < mid)
	{
		result[i1 + i2] = A[left + i1];
		i1++;
	}
	while (mid + i2 < right)
	{
		result[i1 + i2] = A[mid + i2];
		i2++;
	}
	for (int i = 0; i < i1 + i2; i++)
	{
		A[left + i] = result[i];
	}
	return A;
}

void assign(vector A, vector B, int from, int to)
{
	for (int i = from; i < to; i++)
	{
		A[i] = B[i];
	}
}

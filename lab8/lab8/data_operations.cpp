#include "stdafx.h"
#include "data_operations.h"
#include <iostream>
#include <iomanip>
#include <algorithm>    // std::swap

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
		std::cout << std::setw(4) << A[i];
	}
}

void output(matrix MA, int n)
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			std::cout << std::setw(4) << MA[i][j];
		}
		std::cout << std::endl;
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
	//for (int i = 0; i < n; i++)
	//{
	//	for (int j = from; j < to; j++)
	//	{
	//		MB[i][j] = MC[i][j];
	//	}
	//}
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
		C[j] = B[j]*a;
	}
	return C;
}

vector amount(vector A, vector B, int from, int to, int n) {
	vector C = new int[n];
	for (int j = from; j < to; j++)
	{
		C[j] = A[j]+B[j];
	}
	return C;
}

vector sort(vector A, int from, int to) {
	for (int i = from; i <= to; i++) {
		for (int j = from; j <= to - i; j++) {
			if (A[j] < A[j + 1]) {
				std::swap(A[j], A[j + 1]);
				std::cout << A[j] << " " << A[j + 1];
				output(A, 20);
				std::cout << std::endl;
			}
		}
	}
	return A;
}
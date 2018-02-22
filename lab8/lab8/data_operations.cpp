#include "stdafx.h"
#include "data_operations.h"
#include <iostream>
#include <iomanip>

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
		std::cout << std::setw(5) << A[i];
	}
}

void output(matrix MA, int n)
{
	for (int i = 0; i < n; i++)
	{
		for (int j = 0; j < n; j++)
		{
			std::cout << std::setw(5) << MA[i][j];
		}
		std::cout << std::endl;
	}
}

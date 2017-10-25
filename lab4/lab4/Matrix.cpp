#include "stdafx.h"
#include "Matrix.h"
#include <iostream>
using namespace std;


void Matrix::Generate()
{
	if (Value == nullptr) return;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			Value[i][j] = 1;
		}
	}
}

Matrix::Matrix(int count)
{
	N = count;
	Value = new int *[N];
	for (int i = 0; i < N; i++) {
		Value[i] = new int[N];
	}
	Generate();
}

Matrix::~Matrix()
{
}

int Matrix::getN()
{
	return N;
}

void Matrix::Output()
{
	if (Value == nullptr) return;
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			cout << Value[i][j] << "\t";
		}
		cout << endl;
	}
}

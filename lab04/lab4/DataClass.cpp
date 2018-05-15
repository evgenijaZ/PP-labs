#include "stdafx.h"
#include "DataClass.h"
#include <iostream>
using namespace std;

int DataClass::Max(Vector A)
{
	int maxItem = A.Value[0];
	for (int i = 0; i < N; i++)
		if (A.Value[i] > maxItem) maxItem = A.Value[i];

	return maxItem;
}

Vector DataClass::Amount(Vector A, Vector B)
{
	if (N != N)
	{
		cout << "Vectors should have the same length";
		return 0;
	}
	Vector C(N);
	for (int i = 0; i < N; i++)
	{
		C.Value[i] = A.Value[i] + B.Value[i];
	}
	return C;
}

Matrix DataClass::Amount(Matrix A, Matrix B)
{
	if (N != N)
	{
		cout << "Matrices should have the same dimension";
		return 0;
	}
	Matrix C(N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			C.Value[i][j] = A.Value[i][j] + B.Value[i][j];
		}
	}
	return C;
}

Matrix DataClass::Multiple(Matrix A, Matrix B)
{
	if (N != N)
	{
		cout << "Matrices should have the same dimension";
		return 0;
	}
	Matrix C(N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			C.Value[i][j] = 0;
			for (int inner = 0; inner < N; inner++)
			{
				C.Value[i][j] = C.Value[i][j] + A.Value[i][inner] * B.Value[inner][j];
			}
		}
	}
	return C;
}

Vector DataClass::Multiple(Matrix A, Vector B)
{
	if (N != N)
	{
		cout << "Matrix and vector should have the same dimension";
		return 0;
	}
	Vector C(N);
	for (int i = 0; i < N; i++)
	{
		C.Value[i] = 0;
		for (int j = 0; j < N; j++)
		{
			C.Value[i] = C.Value[i] + A.Value[i][j] * B.Value[j];
		}
	}
	return C;
}

Matrix DataClass::Multiple(int A, Matrix B)
{
	Matrix C(N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			C.Value[i][j] = A * B.Value[i][j];
		}
	}
	return C;
}

Matrix DataClass::Trans(Matrix A)
{
	Matrix B(N);
	for (int i = 0; i < N; i++)
	{
		for (int j = 0; j < N; j++)
		{
			B.Value[i][j] = A.Value[j][i];
		}
	}
	return B;
}

DataClass::DataClass(int count)
{
	N = count;
}

Matrix DataClass::F1(Matrix A, Matrix D, Vector B)
{
	Matrix E(N);
	E = Multiple(Max(B), Multiple(A, D));
	return E;
}

Matrix DataClass::F2(int A, Matrix G, Matrix K, Matrix L)
{
	Matrix F(N);
	F = Amount(Multiple(A, Trans(G)), Multiple(K, L));
	return F;
}

Vector DataClass::F3(Matrix P, Matrix R, Vector S, Vector T)
{
	Vector O(N);
	O = Amount(Multiple(Multiple(P, R), S), T);
	return O;
}

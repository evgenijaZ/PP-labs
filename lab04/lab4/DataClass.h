#pragma once
#include "Vector.h"
#include "Matrix.h"
class DataClass
{
private:
	int N;

	int Max(Vector A);
	Vector Amount(Vector A, Vector B);

	Matrix Amount(Matrix A, Matrix B);

	Matrix Multiple(Matrix A, Matrix B);

	Vector Multiple(Matrix A, Vector B);

	Matrix Multiple(int A, Matrix B);

	Matrix Trans(Matrix A);


public:
	DataClass(int count);

	Matrix F1(Matrix A, Matrix D, Vector B);
	Matrix F2(int A, Matrix G, Matrix K, Matrix L);
	Vector F3(Matrix P, Matrix R, Vector S, Vector T);
};


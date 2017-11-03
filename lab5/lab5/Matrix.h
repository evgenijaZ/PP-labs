#pragma once
class Matrix
{
private:

	int N = 0;

	void Generate();

public:

	int **Value;

	Matrix(int count);
	~Matrix();
	int getN();
	void Output();
};


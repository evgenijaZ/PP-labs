#pragma once
class Vector
{
private:
	int N = 0;

	void Generate();

public:
	int *Value;

	int getN();

	Vector(int count);

	void Output();

	~Vector();
};


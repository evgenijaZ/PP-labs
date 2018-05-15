#include "stdafx.h"
#include "Vector.h"

#include <iostream>
using namespace std;

void Vector::Generate()
{
	if (Value == nullptr) return;
	for (int i = 0; i < N; i++)
	{
		Value[i] = 1;
	}
}

int Vector::getN()
{
	return N;
}

Vector::Vector(int count)
{
	N = count;
	Value = new int[N];
	Generate();
}

void Vector::Output()
{
	if (Value == nullptr) return;
	for (int i = 0; i < N; i++)
	{
		cout << Value[i] << "\t";
	}
	cout << endl;
}

Vector::~Vector()
{
}

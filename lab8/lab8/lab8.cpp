// lab8.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <windows.h>
#include "data_operations.h"


const int N = 20;
const int P = 4;
const int H = N / P;

int d;
int x;
vector E = new int[N];
vector S = new int[N];
matrix MO = CreateMatrix(N);
matrix MK = CreateMatrix(N);

void T1() {
	std::cout << "T1 started" << std::endl;  

	int d1, x1;
	vector S1 = new int[N];
	matrix MO1 = CreateMatrix(N);


	std::cout << "T1 finished" << std::endl;
}

void T2() {
	std::cout << "T2 started" << std::endl;

	int d2, x2;
	vector S2 = new int[N];
	matrix MO2 = CreateMatrix(N);

	std::cout << "T2 finished" << std::endl;
}

void T3() {
	std::cout << "T3 started" << std::endl;

	int d3, x3;
	vector S3 = new int[N];
	matrix MO3 = CreateMatrix(N);

	std::cout << "T3 finished" << std::endl;
}

void T4() {
	std::cout << "T4 started" << std::endl;

	int d4, x4;
	vector S4 = new int[N];
	matrix MO4 = CreateMatrix(N);

	std::cout << "T4 finished" << std::endl;
}

int main()
{
    return 0;
}



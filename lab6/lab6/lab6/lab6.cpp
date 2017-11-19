// lab6.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <mpi.h>
#include <iostream>
#include "DataClass.h"
using std::cout;
using std::cin;
using std::endl;

int N = 0;
void F1();
void F2();
void F3();

int main(int argc, char **argv)
{
	
	cout << "Main thread started" << endl;
	cin >> N;

	int ProcNum;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &ProcNum);
	
	MPI_Finalize();
	return 0;
}


void F1() {
	cout << "Thread #1 started" << endl;
	DataClass Manager(N);
	Matrix A(N);
	Matrix D(N);
	Vector B(N);
	Matrix E(N);
	E = Manager.F1(A, D, B);
	cout << endl << "Matrix E (thread #1):" << endl;
	E.Output();
	cout << endl << "Thread #1 finished" << endl;

}
void F2() {
	cout << "Thread #2 started" << endl;
	DataClass Manager(N);
	Matrix G(N);
	Matrix K(N);
	Matrix L(N);
	Matrix F = Manager.F2(5, G, K, L);
	cout << endl << "Matrix F (thread #2):" << endl;
	F.Output();
	cout << endl << "Thread #2 finished" << endl;
}
void F3() {

	cout << "Thread #3 started" << endl;
	DataClass Manager(N);
	Matrix P(N);
	Matrix R(N);
	Vector S(N);
	Vector T(N);
	Vector O = Manager.F3(P, R, S, T);
	cout << endl << "Vector O (thread #3):" << endl;
	O.Output();
	cout << endl << "Thread #3 finished" << endl;
}



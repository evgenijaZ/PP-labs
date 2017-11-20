// lab6.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <mpi.h>
#include "DataClass.h"
#include "Printer.h"
using std::cout;
using std::cin;
using std::endl;

int N = 0;
Matrix F1(Printer* p);
Matrix F2(Printer* p);
Vector F3(Printer* p);
int main(int argc, char **argv)
{
	cin >> N;
	int ProcNum, ProcRank, RecvRank;
	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &ProcNum);
	MPI_Comm_rank(MPI_COMM_WORLD, &ProcRank);
	Printer* pr = new Printer();

	switch (ProcRank)
	{
	case 0:	
	{
		F1(pr);		
		break; 
	}
	case 1: 
	{ 
		F2(pr);
		break;
	}
	case 2: 
	{
		F3(pr);
		break; 
	}
	default:
		break;
	}

	MPI_Finalize();
	cin.get();
	return 0;

}


Matrix F1(Printer *p) {
	p->Show("Thread #1 started\n");
	DataClass Manager(N);
	Matrix A(N);
	Matrix D(N);
	Vector B(N);
	Matrix E(N);
	E = Manager.F1(A, D, B);
	p->Show("\nMatrix E (thread #1):\n");
	p->Show(&E);
	p->Show("\nThread #1 finished\n");

	return E;

}
Matrix F2(Printer* p) {
	p->Show("Thread #2 started\n");

	DataClass Manager(N);
	Matrix G(N);
	Matrix K(N);
	Matrix L(N);
	Matrix F = Manager.F2(5, G, K, L);
	p->Show("\nMatrix F (thread #2):\n");
	p->Show(&F);
	p->Show("\nThread #2 finished\n");

	return F;
}
Vector F3(Printer *p) {

	p->Show("Thread #3 started\n");
	DataClass Manager(N);
	Matrix P(N);
	Matrix R(N);
	Vector S(N);
	Vector T(N);
	Vector O = Manager.F3(P, R, S, T);
	
	p->Show("\nVector O (thread #3):\n");
	p->Show(&O);
	p->Show("\nThread #3 finished\n");

	return O;
}



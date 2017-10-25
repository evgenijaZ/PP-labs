#include "stdafx.h"
#include "Threads.h"
#include <iostream>
using namespace std;

extern HANDLE hSemaphore;
extern int N;

DWORD WINAPI Thread1(LPVOID t)
{
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << "Thread #1 started" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);

	DataClass Manager(N);
	Matrix A(N);
	Matrix D(N);
	Vector B(N);
	Matrix E(N);
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << endl << "Matrix E (thread #1):" << endl;
	E = Manager.F1(A, D, B);
	E.Output();
	cout << endl << "Thread #1 finished" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);
	return 0;
}

DWORD WINAPI Thread2(LPVOID t)
{
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << endl << "Thread #2 started" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);

	DataClass Manager(N);
	Matrix G(N);
	Matrix K(N);
	Matrix L(N);
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << endl << "Matrix F (thread #2):" << endl;
	Matrix F = Manager.F2(5, G, K, L);
	F.Output();
	cout << endl << "Thread #2 finished" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);

	return 0;
}

DWORD WINAPI Thread3(LPVOID t)
{
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << endl << "Thread #3 started" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);

	DataClass Manager(N);
	Matrix P(N);
	Matrix R(N);
	Vector S(N);
	Vector T(N);
	WaitForSingleObject(hSemaphore, INFINITE);
	cout << endl << "Vector O (thread #3):" << endl;
	Vector O = Manager.F3(P, R, S, T);
	O.Output();
	cout << endl << "Thread #3 finished" << endl;
	ReleaseSemaphore(hSemaphore, 1, NULL);
	return 0;
}


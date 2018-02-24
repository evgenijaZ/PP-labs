// lab8.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <windows.h>
#include "data_operations.h"


const int N = 23;
const int P = 4;
const int H = N / P;

int d;
int x;
vector A = new int[N];
vector E = new int[N];
vector S = new int[N];
matrix MO = create_matrix(N);
matrix MK = create_matrix(N);


HANDLE Event_in[3],
Mutex1, Sem[3];
CRITICAL_SECTION CrSec1_copy, CrSec2_output;


void T1() {
	EnterCriticalSection(&CrSec2_output);
	std::cout << "T1 started" << std::endl;
	LeaveCriticalSection(&CrSec2_output);
	int from = 0;
	int to = H;

	int d1, x1;
	vector S1 = new int[N];
	matrix MO1 = create_matrix(N);

	vector R = new int[N];

	//input MK, E
	fill_with_one(MK, N);
	fill_with_one(E, N);


	// Signal to T2, T3, T4 (MK, E are entered)
	SetEvent(Event_in[0]);

	//Wait for T2, T3, and
	WaitForMultipleObjects(4, Event_in, true, INFINITE);

	//copy d,x,S,MO
	EnterCriticalSection(&CrSec1_copy);
	d1 = d;
	x1 = x;
	for (int i = 0; i < N; i++) {
		S1[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO1[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CrSec1_copy);

	//calculating
	assign(A, sort(amount(multiple(d1, E, from, to, N), multiple(S, multiple(MO1, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);


	//merge sort...

	WaitForMultipleObjects(3, Sem, true, INFINITE);

	//output
	EnterCriticalSection(&CrSec2_output);
	output(A, N);
	std::cout << "T1 finished" << std::endl;
	LeaveCriticalSection(&CrSec2_output);

}

void T2() {
	EnterCriticalSection(&CrSec2_output);
	std::cout << "T2 started" << std::endl;
	LeaveCriticalSection(&CrSec2_output);

	int from = H;
	int to = 2 * H;


	int d2, x2;
	vector S2 = new int[N];
	matrix MO2 = create_matrix(N);

	//Wait for T1, T3, and T4
	WaitForMultipleObjects(3, Event_in, true, INFINITE);
	//copy d,x,S,MO
	EnterCriticalSection(&CrSec1_copy);
	d2 = d;
	x2 = x;
	for (int i = 0; i < N; i++) {
		S2[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO2[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CrSec1_copy);

	//calculating
	assign(A, sort(amount(multiple(d2, E, from, to, N), multiple(S, multiple(MO2, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

	ReleaseSemaphore(Sem[0], 1, NULL);

	EnterCriticalSection(&CrSec2_output);
	std::cout << "T2 finished" << std::endl;
	LeaveCriticalSection(&CrSec2_output);

}

void T3() {
	EnterCriticalSection(&CrSec2_output);
	std::cout << "T3 started" << std::endl;
	LeaveCriticalSection(&CrSec2_output);

	int from = 2 * H;
	int to = 3 * H;

	int d3, x3;
	vector S3 = new int[N];
	matrix MO3 = create_matrix(N);

	//input d, S
	d = 1;
	fill_with_one(S, N);

	// Signal to T1, T2, T4 (d, S are entered)
	SetEvent(Event_in[1]);

	//Wait for T1, T2, T4
	WaitForMultipleObjects(3, Event_in, true, INFINITE);


	//copy d,x,S,MO
	EnterCriticalSection(&CrSec1_copy);
	d3 = d;
	x3 = x;
	for (int i = 0; i < N; i++) {
		S3[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO3[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CrSec1_copy);

	//calculating
	assign(A, sort(amount(multiple(d3, E, from, to, N), multiple(S, multiple(MO3, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

	ReleaseSemaphore(Sem[1], 1, NULL);

	EnterCriticalSection(&CrSec2_output);
	std::cout << "T3 finished" << std::endl;
	LeaveCriticalSection(&CrSec2_output);

}

void T4() {
	EnterCriticalSection(&CrSec2_output);
	std::cout << "T4 started" << std::endl;
	LeaveCriticalSection(&CrSec2_output);
	
	int from = 3 * H;
	int to = N;
	int d4, x4;
	vector S4 = new int[N];
	matrix MO4 = create_matrix(N);

	//input x, MO
	x = 1;
	fill_with_one(MO, N);

	// Signal to T1, T2, T3 (x, MO are entered)
	SetEvent(Event_in[2]);

	//Wait for T1, T2, T3
	WaitForMultipleObjects(3, Event_in, true, INFINITE);


	//copy d,x,S,MO
	EnterCriticalSection(&CrSec1_copy);
	d4 = d;
	x4 = x;
	for (int i = 0; i < N; i++) {
		S4[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO4[i][j] = MO[i][j];
		}
	}

	LeaveCriticalSection(&CrSec1_copy);

	//calculating
	assign(A, sort(amount(multiple(d4, E, from, to, N), multiple(S, multiple(MO4, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

	ReleaseSemaphore(Sem[2], 1, NULL);

	EnterCriticalSection(&CrSec2_output);
	std::cout << std::endl << "T4 finished" << std::endl;
	LeaveCriticalSection(&CrSec2_output);
}

int main()
{

	Event_in[0] = CreateEvent(NULL, TRUE, FALSE, NULL);
	Event_in[1] = CreateEvent(NULL, TRUE, FALSE, NULL);
	Event_in[2] = CreateEvent(NULL, TRUE, FALSE, NULL);


	Sem[0] = CreateSemaphore(NULL, 0, 1, NULL);
	Sem[1] = CreateSemaphore(NULL, 0, 1, NULL);
	Sem[2] = CreateSemaphore(NULL, 0, 1, NULL);

	InitializeCriticalSection(&CrSec1_copy);
	InitializeCriticalSection(&CrSec2_output);

	DWORD Tid1, Tid2, Tid3, Tid4;
	HANDLE threads[] =
	{
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T1, NULL, NULL, &Tid1),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T2, NULL, NULL, &Tid2),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T3, NULL, NULL, &Tid3),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T4, NULL, NULL, &Tid4)
	};
	WaitForMultipleObjects(4, threads, true, INFINITE);
	CloseHandle(threads[0]);
	CloseHandle(threads[1]);
	CloseHandle(threads[2]);
	CloseHandle(threads[3]);

	CloseHandle(Event_in[0]);
	CloseHandle(Event_in[1]);
	CloseHandle(Event_in[2]);

	CloseHandle(Sem[0]);
	CloseHandle(Sem[1]);
	CloseHandle(Sem[2]);

	DeleteCriticalSection(&CrSec1_copy);
	DeleteCriticalSection(&CrSec2_output);

	std::cin.get();
	return 0;
}



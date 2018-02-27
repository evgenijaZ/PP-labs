// lab8.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <windows.h>
#include "data_operations.h"


const int N = 10;
const int P = 4;
const int H = N / P;

int d;
int x;
vector A = new int[N];
vector E = new int[N];
vector S = new int[N];
matrix MO = create_matrix(N);
matrix MK = create_matrix(N);


HANDLE Event_input[3], Mutex_merge[2], Sem_calc[4];
CRITICAL_SECTION CriticalSection_copy;

//_______________________________________________________________________
//
//----------------------------------T1-----------------------------------
//_______________________________________________________________________
void T1() {
	std::cout << "T1 started\n";
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
	SetEvent(Event_input[0]);

	//Wait for T2, T3, and T4
	WaitForMultipleObjects(4, Event_input, true, INFINITE);

	//copy d,x,S,MO
	EnterCriticalSection(&CriticalSection_copy);
	d1 = d;
	x1 = x;
	for (int i = 0; i < N; i++) {
		S1[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO1[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CriticalSection_copy);

	//calculating
	assign(A, sort(amount(multiple(d1, E, from, to, N), multiple(S, multiple(MO1, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);
	
	//Signal to T2,T3,T4
	ReleaseSemaphore(Sem_calc[0], 1, NULL);

	//Wait for T2,T3
	WaitForMultipleObjects(2, Mutex_merge, true, INFINITE);

	//merge sort
	assign(A, merge_sort(A, 0, N), 0, N);
	
	//output
	if (N<10)
		output(A, N);
	
	std::cout << "T1 finished\n";
}

//_______________________________________________________________________
//
//----------------------------------T2-----------------------------------
//_______________________________________________________________________
void T2() {
	std::cout << "T2 started\n";

	int from = H;
	int to = 2 * H;

	int d2, x2;
	vector S2 = new int[N];
	matrix MO2 = create_matrix(N);

	//Wait for T1, T3, and T4
	WaitForMultipleObjects(3, Event_input, true, INFINITE);
	
	//copy d,x,S,MO
	EnterCriticalSection(&CriticalSection_copy);
	d2 = d;
	x2 = x;
	for (int i = 0; i < N; i++) {
		S2[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO2[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CriticalSection_copy);

	//calculating
	assign(A, sort(amount(multiple(d2, E, from, to, N), multiple(S, multiple(MO2, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);
	
	//Signal to T1,T2,T3
	ReleaseSemaphore(Sem_calc[1], 1, NULL);

	//Wait for calculating in T1,T3,T4
	WaitForMultipleObjects(4, Sem_calc, true, INFINITE);

	//merge 1 and 2 parts
	assign(A, merge_sort(A, 0, 2 * H), 0, 2 * H);

	//Signal to T1
	ReleaseMutex(Mutex_merge[0]);

	std::cout << "T2 finished\n";
}
//_______________________________________________________________________
//
//----------------------------------T3-----------------------------------
//_______________________________________________________________________
void T3() {
	std::cout << "T3 started\n";

	int from = 2 * H;
	int to = 3 * H;

	int d3, x3;
	vector S3 = new int[N];
	matrix MO3 = create_matrix(N);

	//input d, S
	d = 1;
	fill_with_one(S, N);

	// Signal to T1, T2, T4 (d, S are entered)
	SetEvent(Event_input[1]);

	//Wait for T1, T2, T4
	WaitForMultipleObjects(3, Event_input, true, INFINITE);


	//copy d,x,S,MO
	EnterCriticalSection(&CriticalSection_copy);
	d3 = d;
	x3 = x;
	for (int i = 0; i < N; i++) {
		S3[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO3[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CriticalSection_copy);

	//calculating
	assign(A, sort(amount(multiple(d3, E, from, to, N), multiple(S, multiple(MO3, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);

	ReleaseSemaphore(Sem_calc[2], 1, NULL);

	//Wait for calculating in T1,T2,T4
	WaitForMultipleObjects(4, Sem_calc, true, INFINITE);

	//merge 3 and 4 parts
	assign(A, merge_sort(A, 2 * H, N), 2 * H, N);
	
	//Signal to T1
	ReleaseMutex(Mutex_merge[1]);

	std::cout << "T3 finished\n";
}
//_______________________________________________________________________
//
//----------------------------------T4-----------------------------------
//_______________________________________________________________________
void T4() {
	std::cout << "T4 started\n";

	int from = 3 * H;
	int to = N;
	int d4, x4;
	vector S4 = new int[N];
	matrix MO4 = create_matrix(N);

	//input x, MO
	x = 1;
	fill_with_one(MO, N);

	// Signal to T1, T2, T3 (x, MO are entered)
	SetEvent(Event_input[2]);

	//Wait for T1, T2, T3
	WaitForMultipleObjects(3, Event_input, true, INFINITE);

	//copy d,x,S,MO
	EnterCriticalSection(&CriticalSection_copy);
	d4 = d;
	x4 = x;
	for (int i = 0; i < N; i++) {
		S4[i] = S[i];
		for (int j = 0; j < N; j++) {
			MO4[i][j] = MO[i][j];
		}
	}
	LeaveCriticalSection(&CriticalSection_copy);

	//calculating
	assign(A, sort(amount(multiple(d4, E, from, to, N), multiple(S, multiple(MO4, MK, from, to, N), from, to, N), from, to, N), from, to), from, to);
	
	//Signal to T1,T2,T3
	ReleaseSemaphore(Sem_calc[3], 1, NULL);

	std::cout << "\nT4 finished\n";
}
//_______________________________________________________________________
//
//---------------------------------MAIN----------------------------------
//_______________________________________________________________________
int main()
{

	Event_input[0] = CreateEvent(NULL, TRUE, FALSE, NULL);
	Event_input[1] = CreateEvent(NULL, TRUE, FALSE, NULL);
	Event_input[2] = CreateEvent(NULL, TRUE, FALSE, NULL);

	Sem_calc[0] = CreateSemaphore(NULL, 0, 1, NULL);
	Sem_calc[1] = CreateSemaphore(NULL, 0, 1, NULL);
	Sem_calc[2] = CreateSemaphore(NULL, 0, 1, NULL);
	Sem_calc[3] = CreateSemaphore(NULL, 0, 1, NULL);

	Mutex_merge[0] = CreateMutex(NULL, FALSE, NULL);
	Mutex_merge[1] = CreateMutex(NULL, FALSE, NULL);

	InitializeCriticalSection(&CriticalSection_copy);

	DWORD Tid1, Tid2, Tid3, Tid4;
	HANDLE threads[] =
	{
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T1, NULL, NULL, &Tid1),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T2, NULL, NULL, &Tid2),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T3, NULL, NULL, &Tid3),
		CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)T4, NULL, NULL, &Tid4)
	};

	//WaitForMultipleObjects(4, threads, true, INFINITE);
	WaitForSingleObject(threads[1], INFINITE);
	
	CloseHandle(threads[0]);
	CloseHandle(threads[1]);
	CloseHandle(threads[2]);
	CloseHandle(threads[3]);

	CloseHandle(Event_input[0]);
	CloseHandle(Event_input[1]);
	CloseHandle(Event_input[2]);

	CloseHandle(Sem_calc[0]);
	CloseHandle(Sem_calc[1]);
	CloseHandle(Sem_calc[2]);
	CloseHandle(Sem_calc[3]);

	CloseHandle(Mutex_merge[0]);
	CloseHandle(Mutex_merge[1]);

	DeleteCriticalSection(&CriticalSection_copy);

	system("pause");

	return 0;
}



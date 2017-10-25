// lab4.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include"Threads.h"
#include <iostream>
using namespace std;

HANDLE hSemaphore;
int N = 0;

int main()
{
	cout << "Main thread started" << endl;
	cin >> N;
	hSemaphore = CreateSemaphore(NULL, 1, 1, NULL);

	HANDLE thread1 = CreateThread(NULL, 0, Thread1, NULL, CREATE_SUSPENDED, NULL);
	HANDLE thread2 = CreateThread(NULL, 0, Thread2, NULL, CREATE_SUSPENDED, NULL);
	HANDLE thread3 = CreateThread(NULL, 0, Thread3, NULL, CREATE_SUSPENDED, NULL);

	ResumeThread(thread1);
	ResumeThread(thread2);
	ResumeThread(thread3);

	SetThreadPriority(thread1, THREAD_PRIORITY_HIGHEST);
	SetThreadPriority(thread2, THREAD_PRIORITY_NORMAL);
	SetThreadPriority(thread3, THREAD_PRIORITY_LOWEST);
	WaitForSingleObject(thread1, INFINITE);
	WaitForSingleObject(thread2, INFINITE);
	WaitForSingleObject(thread3, INFINITE);
	CloseHandle(thread1);
	CloseHandle(thread2);
	CloseHandle(thread3);
	cout << "Main thread finished" << endl;
	system("pause");
	return 0;
}




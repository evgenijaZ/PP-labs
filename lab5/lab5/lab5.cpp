// lab5.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <omp.h>
#include <iostream>
#include "DataClass.h"
using std::cout;
using std::cin;
using std::endl;

int main()
{
	int N = 0;
	cout << "Main thread started" << endl;
	cin >> N;

#pragma omp parallel
	{
#pragma omp sections
		{
#pragma omp section
			{
#pragma omp critical
				{
					cout << "Thread #1 started" << endl;
				}
				DataClass Manager(N);
				Matrix A(N);
				Matrix D(N);
				Vector B(N);
				Matrix E(N);
				E = Manager.F1(A, D, B);
#pragma omp critical
				{
					cout << endl << "Matrix E (thread #1):" << endl;
					E.Output();
					cout << endl << "Thread #1 finished" << endl;
				}

			}
#pragma omp section
			{
#pragma omp critical
				{
					cout << "Thread #2 started" << endl;
				}
				DataClass Manager(N);
				Matrix G(N);
				Matrix K(N);
				Matrix L(N);
				Matrix F = Manager.F2(5, G, K, L);
#pragma omp critical
				{
					cout << endl << "Matrix F (thread #2):" << endl;
					F.Output();
					cout << endl << "Thread #2 finished" << endl;
				}

			}
#pragma omp section
			{
#pragma omp critical
				{
					cout << "Thread #3 started" << endl;
				}
				DataClass Manager(N);
				Matrix P(N);
				Matrix R(N);
				Vector S(N);
				Vector T(N);
				Vector O = Manager.F3(P, R, S, T);
#pragma omp critical
				{
					cout << endl << "Vector O (thread #3):" << endl;
					O.Output();
					cout << endl << "Thread #3 finished" << endl;

				}

			}
		}
#pragma omp barrier 
	}

	std:: cout << "Main thread finished" << std::endl;
	system("pause");
	return 0;
}


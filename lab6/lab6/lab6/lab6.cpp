// lab6.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <mpi.h>
#include <iostream>

int main(int argc, char **argv)
{
	int ProcNum;

	MPI_Init(&argc, &argv);
	MPI_Comm_size(MPI_COMM_WORLD, &ProcNum);
	
	MPI_Finalize();
	return 0;
}


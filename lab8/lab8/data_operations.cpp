#include "data_operations.h"

matrix CreateMatrix(int N) {
	matrix MA = new vector[N];
	for (int i = 0; i < N; i++) {
		MA[i] = new int[N];
	}
	return MA;
}
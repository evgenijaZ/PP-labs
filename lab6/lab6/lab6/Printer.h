#pragma once
#include "Vector.h"
#include "Matrix.h"
#include <iostream>
#include <omp.h>
class Printer {
private:
	omp_lock_t writelock;
public:
	Printer();
	void Show(Vector* vec);
	void Show(Matrix* mat);
	void Show(const char* str);
};

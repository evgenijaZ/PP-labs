#include "stdafx.h"
#include "Printer.h"

Printer::Printer()
{
	omp_init_lock(&writelock);
}

void Printer::Show(Vector * vec)
{
	omp_set_lock(&writelock);
	vec->Output();
	omp_unset_lock(&writelock);
}

void Printer::Show(Matrix * mat)
{
	omp_set_lock(&writelock);
	mat->Output();
	omp_unset_lock(&writelock);
}
void Printer::Show(const char* str)
{
	omp_set_lock(&writelock);
	std::cout << str;
	omp_unset_lock(&writelock);
}
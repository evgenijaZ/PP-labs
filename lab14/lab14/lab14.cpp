
#include "stdafx.h"
#include <iostream>
#include <sstream>
#include <mpi.h>
#include <time.h>
#include <vector>
#include <algorithm>

using namespace std;

const int N = 14;
const int P = 14;
const int H = N / P;

void fillMatrix(long long*, long long dim1, long long val);
void fillVector(long long*, long long dim1, long long val);
void printMatrix(std::ostream&, long long*, long long);
void printVector(std::ostream&, long long*, long long);
void printMatrix(long long*, long long);
void printVector(long long*, long long);

MPI_Comm graph_comm;
MPI_Group world_group, base_group, star_group;
MPI_Comm base_comm, star_comm;

int main(int argc, char* argv[]) {
  int input_dimension[] = {N, H * 2, H * 3, H * 4, H * 4, H, H,
                           H, H,     H,     H,     H,     H, H};

  MPI_Init(&argc, &argv);

  int curr_P = 0;
  MPI_Comm_size(MPI_COMM_WORLD, &curr_P);
  if (curr_P != P) {
    return error("Invalid number of processes");
  }

  int rank;
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);

  long long zi = 0;
  long long z = 0;

  long long d = 0;
  long long T[N]{0};
  long long* B = new long long[input_dimension[rank]]{0};
  long long* Z = new long long[input_dimension[rank]]{0};

  long long MO[N][N]{0};
  long long** MK = new long long* [N] { 0 };

  for (int i = 0; i < N; i++) MK[i] = new long long[input_dimension[rank]];

  long long A_[N]{0};
  long long* A = new long long[input_dimension[rank]]{0};
  ;
  long long MR[N][N]{0};

  int index[] = {4, 6, 9, 13, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26};
  int edges[] = {1, 2,  3,  4,  0, 5, 0, 6, 7, 0, 8, 9, 10,
                 0, 11, 12, 13, 1, 2, 2, 3, 3, 3, 4, 4, 4};
  MPI_Graph_create(MPI_COMM_WORLD, 14, index, edges, false, &graph_comm);

  MPI_Comm_group(MPI_COMM_WORLD, &world_group);
  int base_group_ranks[]{0, 1, 2, 3, 4};
  MPI_Group_incl(world_group, 5, base_group_ranks, &base_group);
  MPI_Comm_create(MPI_COMM_WORLD, base_group, &base_comm);

  std::vector<std::vector<int> > groups{
      {0}, {1, 5}, {2, 6, 7}, {3, 8, 9, 10}, {4, 11, 12, 13},
  };

  auto group =
      std::find_if(groups.begin(), groups.end(),
                   [&rank](const std::vector<int>& gr) -> bool {
                     return std::find(gr.begin(), gr.end(), rank) != gr.end();
                   });
  if (group == groups.end()) {
    return error("Cannot create groups properly. Cannot find group for rank: " +
                 rank);
  }

  std::vector<int>& subgroup = *group;
  long group_index = std::distance(groups.begin(), group);

  MPI_Group_incl(world_group, static_cast<int>(group->size()), &(*group)[0],
                 &star_group);
  MPI_Comm_create(MPI_COMM_WORLD, star_group, &star_comm);

  cout << "Thread " << rank + 1 << " started.\n";

  if (rank == 0) {
    d = 1;
    fillVector(&Z[0], N, 1);
    fillVector(&B[0], N, 1);
    fillVector(&T[0], N, 1);
    fillMatrix(&MO[0][0], N, 1);
    fillMatrix(&MK[0][0], N, 1);
  }

  MPI_Bcast(&d, 1, MPI_LONG_LONG, 0, graph_comm);
  MPI_Bcast(&T[0], N, MPI_LONG_LONG, 0, graph_comm);
  MPI_Bcast(&MO[0][0], N * N, MPI_LONG_LONG, 0, graph_comm);

  if (rank < 5) {
    int b_sendcounts[5]{H};
    int z_sendcounts[5]{H};
    int mk_sendcounts[5]{N * H};
    int b_displs[]{0};
    int z_displs[]{0};
    int mk_displs[]{0};

    for (int i = 1; i < 5; ++i) {
      z_sendcounts[i] = input_dimension[i];
      b_sendcounts[i] = input_dimension[i];
      mk_sendcounts[i] = N * input_dimension[i];

      z_displs[i] = z_displs[i - 1] + z_sendcounts[i - 1];
      b_displs[i] = b_displs[i - 1] + b_sendcounts[i - 1];
      mk_displs[i] = mk_displs[i - 1] + mk_sendcounts[i - 1];
    }

    MPI_Scatterv(&Z, z_sendcounts, z_displs, MPI_LONG_LONG,
                 // rank == 0 ? nullptr :
                 &Z,
                 // rank == 0 ? 0 :
                 input_dimension[rank], MPI_LONG_LONG, 0, base_comm);

    MPI_Scatterv(&B, b_sendcounts, b_displs, MPI_LONG_LONG,
                 // rank == 0 ? nullptr :
                 &B,
                 // rank == 0 ? 0 :
                 input_dimension[rank], MPI_LONG_LONG, 0, base_comm);

    MPI_Scatterv(&MK, mk_sendcounts, mk_displs, MPI_LONG_LONG,
                 // rank == 0 ? nullptr :
                 &MK,
                 // rank == 0 ? 0 :
                 N * input_dimension[rank], MPI_LONG_LONG, 0, base_comm);
  }
  if (rank != 0) {
    MPI_Scatter(&Z, H, MPI_LONG_LONG, &Z, H, MPI_LONG_LONG, 0, star_comm);
    MPI_Scatter(&B, H, MPI_LONG_LONG, &B, H, MPI_LONG_LONG, 0, star_comm);
    MPI_Scatter(&MK, H * N, MPI_LONG_LONG, &MK, H * N, MPI_LONG_LONG, 0,
                star_comm);
  }

  zi = Z[0];
  for (long long i = 0; i < H; ++i) {
    if (Z[i] < zi) zi = Z[i];
  }

  MPI_Reduce(&zi, &z, 1, MPI_LONG_LONG, MPI_MIN, 0, graph_comm);

  for (long long i = 0; i < N; i++) {
    for (long long j = 0; j < H; j++) {
      MR[i][j] = 0;
      for (long long k = 0; k < N; k++) {
        MR[i][j] += MO[i][k] * MK[k][j];
      }
    }
  }
  for (long long i = 0; i < H; i++) {
    A[i] = 0;
    for (long long j = 0; j < N; j++) {
      A[i] += z * B[i] * T[j] * MR[j][i];
    }
  }

  if (rank < 5) {
    int a_recvcounts[5]{H};
    int a_displs[]{0};

    for (int i = 1; i < 5; ++i) {
      a_recvcounts[i] = input_dimension[i];
      a_displs[i] = a_displs[i - 1] + a_recvcounts[i - 1];
    }

    MPI_Gatherv(&A, input_dimension[rank], MPI_LONG_LONG, &A_, a_recvcounts,
                a_displs, MPI_LONG_LONG, 0, base_comm);
  }

  if (rank == 0) {
    cout << "Result is " << std::endl;
    for (long long i = 0; i < N; i++) {
      cout << A_[i] << " ";
    }
  }

  cout << "Thread " << rank + 1 << " finish.\n";

  if (rank == 0) {
    MPI_Group_free(&world_group);
    MPI_Comm_free(&graph_comm);
    MPI_Group_free(&base_group);
    MPI_Comm_free(&base_comm);
  } else if (rank == subgroup[0]) {
    MPI_Group_free(&star_group);
    MPI_Comm_free(&star_comm);
  }
  MPI_Finalize();

  if (rank == 0) getchar();

  return 0;
}

void fillVector(long long* V, long long dim1, long long val) {
  for (long long i = 0; i < dim1; i++) {
    V[i] = val;
  }
}

void fillMatrix(long long* MA, long long dim1, long long val) {
  for (long long i = 0; i < dim1; i++) {
    for (long long j = 0; j < N; j++) {
      MA[i * N + j] = val;
    }
  }
}

void printMatrix(std::ostream& stream, long long* MA, long long dim1) {
  for (long long i = 0; i < dim1; i++) {
    for (long long j = 0; j < N; j++) {
      stream << MA[i * N + j] << " ";
    }
    stream << std::endl;
  }
}

void printMatrix(long long* MA, long long dim1) {
  printMatrix(std::cout, MA, dim1);
}

void printVector(std::ostream& stream, long long* v, long long size) {
  for (long long i = 0; i < size; i++) {
    stream << v[i] << " ";
  }
  stream << std::endl;
}

void printVector(long long* v, long long size) {
  printVector(std::cout, v, size);
}

int error(std::string msg) {
  MPI_Finalize();
  cout << msg << "\n";
  return 1;
}
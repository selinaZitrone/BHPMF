//
//  utillity.h
//
//
//  Created by Farideh Fazayeli on 7/18/13.
//
//

#ifndef ____utillity__
#define ____utillity__

#include <R.h>  // R functions
#include <R_ext/BLAS.h>
#include <R_ext/Lapack.h>
#include <R_ext/Linpack.h>
#include <R_ext/Utils.h>
#include <Rinternals.h>
#include <Rmath.h>  // R math
#include <assert.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#include <algorithm>
#include <iostream>
#include <iterator>
#include <map>
#include <set>
#include <sstream>
#include <string>
#include <vector>

using namespace std;

typedef vector<vector<float> > matVecFloat;
typedef vector<vector<int> > matVecInt;
typedef vector<set<int> > vecSet;

void PrintArr(int *myArr, int nRow);
void PrintArr(double *myArr, int nRow);
void printMat(float *myArr, int nRow, int nCol);
void printMat(double *myArr, int nRow, int nCol);
void printMat(float **myMat, int nRow, int nCol);
void printMat(int **myMat, int nRow, int nCol);

SEXP getListElement(SEXP list, const char *str);
void mvrnorm(double *des, double *mu, double *cholCov, int dim, bool upper);

void dlmreadVec(string filePath, matVecFloat &myMat, int &nRow, int nCol,
                int verbose);
void dlmreadVec(string filePath, matVecInt &myMat, int &nRow, int nCol,
                int verbose);
// Reads a text file into a matrix, a very simple code with assumption number
// of rows and number of columns of each row of the matrix is known.
// void dlmreadVec(string filePath, matVecInt &myMat, int nRow, vector<int>
// nCols, int verbose);
void dlmreadVec(string filePath, vector<int> &myArr);

// write the Gibbs sampler output into a text file, a very simple code with
// assumption number of rows of the matrix is known.
void dlmwriteVec(const char *inFilePath, const char *outFilePath, int nRow,
                 int nCol, int gap, int burn, int nSam);

template <class T>
inline void SafeDelete(T x) {
  assert(x != NULL);
  delete[] x;
  x = NULL;
}

#endif /* defined(____utillity__) */

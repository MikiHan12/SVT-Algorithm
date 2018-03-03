/* 
 * Stephen Becker, 11/10/08
 * Updates a sparse vector's nonzero elements
 * calling format:  
 *      updateSparse(Y, y){ 
 *  returns:
 *            Y(omega) = y,     where y = M(omega)
 *
 * Omega, the linear index of non-zero elements, must be pre-sorted.
 *   This is required so that the elements of y and Y vectors are in the same order. 
 * 
 * */

#include "mex.h"

/* extra defines to be extra safe */
#define mwIndex size_t  /* should make it compatible w/ 64-bit systems */

void mexFunction(
         int nlhs,       mxArray *plhs[],
         int nrhs, const mxArray *prhs[]
         )
{
    /* create variables */
    double *Y, *y;
    int i;
    int length;
    int double_size; 
    int num_bytes;
   /* assign values from input arguments */

    y = mxGetPr( prhs[1] );
    Y = mxGetPr( prhs[0] );
    length = mxGetN( prhs[1] );
    double_size = sizeof(Y[0]);
    num_bytes = length * double_size;

   /* update elements  */
   /*    for ( i=0 ; i < length ; i++ ){
     *         Y[i] = y[i];
       } */
   /* use memcopy for speedup */
   memcpy(Y, y, num_bytes);

}

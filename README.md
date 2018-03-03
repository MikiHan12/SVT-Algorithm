# SVT-Algorithm
A Singular Value Thresholding Method for Matrix Completion

## Implementation of the SVT algorithm described in the following paper

J-F Cai, E. J. Candès and Z. Shen, "A Singular Value Thresholding Method for Matrix Completion," SIAM Journal on Optimization, 20(4), 1956-1982.
https://statweb.stanford.edu/~candes/papers/SVT.pdf

Implemented the SVT algorithm to recover 1000 x 1000 matrices; 
Recreated the experimental results; 
Applied tge algorithm to real dataset;
Tested the sensitivity;
Analyzed the similarities and dissimilarities;

## Description of SVT algorithm

1. Minimize the nuclear norm of the matrix under certain constraints.
2. Recovering a large matrix from a small subset of its entries.
3. Simple first-order methods are used for problem whose optimal solution has low rank.
4. Iterative. Produce a sequence of matrix at each step. Perform a soft-thresholding operation on the singular value of sparse matrix.
5. Efficient. Minimal storage space. 



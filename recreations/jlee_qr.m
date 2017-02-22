function [Q,R] = jlee_qr(A)
% This function performs a QR factorization of matrix A.

Q = jlee_gram_schmidt(A,'norm');
R = transpose(Q)*A;

end
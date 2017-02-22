function [Q] = jlee_gram_schmidt(A, Q_type)
% This will produce a matrix Q whose column vectors are an orthogonal
% basis for subspace W spanned by Col A.
% 
% Place the spanning vectors of W as column vectors in matrix A
% Add a second 'norm' input if orthonormal basis is required.
% e.g.
% [Q] = gram_schmidt(A,'norm');

[m,n] = size(A);

Q = zeros(m,n);

for k = 1:n
    
    p = k - 1;
    Q(:,k) = A(:,k);
    
    while p > 0
        
        Q(:,k) = Q(:,k) - dot(A(:,k),Q(:,p))/dot(Q(:,p),Q(:,p))*Q(:,p);
        p = p - 1;
        
    end

    switch nargin
        case 2
            Q(:,k) = Q(:,k)/norm(Q(:,k));
        otherwise
    end
    
end

end
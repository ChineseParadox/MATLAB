function [X] = jlee_dft2(x)

N = length(x);
X = zeros(1,N);

for k = 1:N
    
    n = 0:(N - 1);
    Z = exp(-1i*2*pi*(k - 1)*n/N);
    X(k) = sum(x.*Z);
    
end

end
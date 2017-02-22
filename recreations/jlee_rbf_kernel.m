function matrix_kernel = jlee_rbf_kernel(a, b, param)

    sqdist = pdist2(a, b);
    matrix_kernel = exp(-(1/param)*sqdist/2);

end
function [X_sorted] = jlee_merge_sort(X)

N = length(X);

if (N > 1)
    split = floor(N/2);
    X1 = jlee_merge_sort(X(1:split));
    X2 = jlee_merge_sort(X((split + 1):end));
    X_sorted = jlee_bubble_sort([X1 X2]);
else
    X_sorted = X;
end

end
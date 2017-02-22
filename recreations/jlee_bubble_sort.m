function [X] = jlee_bubble_sort(X)

N = length(X);
m = 0;

while m ~= (N - 1)
    m = 0;
    for k = 1:(N - 1)
        iFirst = k;
        iSecond = k + 1;

        if (X(iFirst) > X(iSecond))
            temp = X(iFirst);
            X(iFirst) = X(iSecond);
            X(iSecond) = temp;
        else
            m = m + 1;
        end
    end
end

end

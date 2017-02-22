function [theta] = jlee_normal_equation(X, y)

inv_quadform = inv(transpose(X)*X);
theta = inv_quadform*tranpose(X)*y;

end
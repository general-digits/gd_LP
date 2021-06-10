
function [D] = getDerivative(A,B,X,y,R,T)

    [m,n] = size(A);
    
    A_ = A*X + B;
    S = zeros(1,n);
    s = 0;
    for i = 1:m
        S = S - A(i,:)/(y - A_(i));
        s = s + 1/(y - A_(i));
    end
    S = S - 2*X'/(R^2 - X'*X);
    D = [-S/T 1-1/T*s];
end
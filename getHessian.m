
function [H] = getHessian(A,B,X,y,R,T)

    [m,n] = size(A);
    
    A_ = A*X + B;
    S =  -4*(X*X')/(R^2 - X'*X)^2-2*eye(n)/(R^2 - X'*X);
    s = 0;
    sy = 0;
    for i = 1:m
        S = S - (A(i,:)'*A(i,:))/(y - A_(i))^2;
        s = s + A(:,i)'/(y - A_(i));
        sy = sy - 1/(y - A_(i))^2;
    end
    
    H = [-S/T -s/T; -s'/T  -sy/T];
end
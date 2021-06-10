function [A,B,rez] = genRandomFeasibleLP(m,n,epsi,R, feasible)
%     generates a random feasible LP with a solution in B(0,R) and 
%     A\cdot X + B <= -epsi

%   gen random constraints
    A = rand(m,n);
%   gen random solution of radius 0.9*R
    X_ = rand(n,1);
    X = X_/(norm(X_)+1e-5)*R*0.9;
%   gen B as expected
    B = zeros(m,1);
    for i = 1:m
        a = A(i,:)*X + epsi;
        
        B(i) = -a;
        Par = sqrt(norm(A(i,:))^2 + B(i)^2);
        A(i,:) = A(i,:)/Par;
        B(i) = B(i)/Par;
        
    end
    if (feasible == 0)
%       make the system infeasible
        A(m,:) = -A(1,:);
        B(m) = -B(1)+1;
    end
    rez = A*X + B;
    
end
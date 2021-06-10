function [found,X,y] = assertLP_feasibility(A,B)

% form the function and minimize it
% f(X,y) = y - 1/t \cdot \sum_{k=1}^m \log(y - (A_k^T \cdot X + b_k))
% f_k(X,y) = \sum_{k=1}^m \log(y - (A_k * X + b_k)) - P*log(yk - y)
    
    [m,n] = size(A);
    
    X = zeros(n,1);
%     y = 2;
    
%   minimize f
    NrK = 100;
    NrP = 30;
    p = 0;
    found = 0;
    
    V = [eye(n); -eye(n)];
    y_old = 2;
    y_old_= 3;
    y = 1.5;
    while (p < NrP) && ((y_old_ - y_old) > 1e-5)
        p = p + 1
        y_old_ = y_old;
    %   minimize f_k (finds a sort of analytic center)
        k = 0;
        al = 10;
        while (k < NrK) && (al > 1e-5)
            k = k + 1
            min_ = get_f(A,B,X,y,y_old);
            advance = 0;
            for i = 1:2*n
                d = V(i,:)';
                [L1, ok1] = get_f(A,B,X+al*d,y+al,y_old);
                [L2, ok2] = get_f(A,B,X+al*d,y-al,y_old);
                if (ok1 == 1) && (L1 < min_)
                    min_ = L1;
                    X_ = X + al*d;
                    y_ = y+al;
                    advance = 1;
                end
                if (ok2 == 1) && (L2 < min_)
                    min_ = L2;
                    X_ = X + al*d;
                    y_ = y-al;
                    advance = 1;
                end
            end
            if (advance == 0)
                al = al/2;
            else
                X = X_;
                y = y_;
                if (max(A*X+B) < 1e-5)
                    found = 1;
                    disp('found');
                    break;
                end
            end
        end % while 1
        if (max(A*X+B) < 1e-5)
            found = 1;
            disp('found');
            break;
        else
            y_old = y+1e-3;
        end
    end % while 2
    
end % func

function [su,ok] = get_f(A,B,X,y,yk)
 re = A*X + B;
 su = 0;
 P = 0.1;
 ok = 1;
 for i = 1:length(re)
     if ((y - re(i)) > 0)
        su = su + log(y - re(i));
     else 
        ok = 0;
        break;
     end
 end
 
 if (ok == 1) && (yk - y > 0)
     su = -su - log(yk - y)*P;
 end
 
end




function x3 = golden_search(f, x1, x2, tol)
    
    % f is a handle to a function 
    % points are numbered in the order they are introduced
    % x3 is defined as that point that is
    % closer to x2 and x4 as that point that is closer to x1 - ALWAYS
    % at the end of the update the interval must ALWAYS be x1, x3, x2
    % with x3 closer to x2. Keeping these guidelines in mind helps
    % determine what the update steps are
    % also keep in mind that interval (x3-x4) / (x1 - x3) = 2 - 1/r
    % = 1-r where r is the golden ratio 0.618 
    
    % get f1 and f2 for initial points 
    f1 = f(x1);
    f2 = f(x2);
    
    r = (sqrt(5) - 1)/2;
    x3 = r*x2 + (1-r)*x1; f3 = f(x3);
    
    % initial x1 and x2 must be picked such that f3 is less than 
    % f1 and f2
   
    while abs(x1-x2) > tol
        x4 = r*x1 + (1-r)*x2; f4 = f(x4);
        if f4 < f3
            x2 = x3; f2 = f3;
            x3 = x4; f3 = f4;
        else % f4 > f3
            x1 = x2; f1 = f2;
            x2 = x4; f2 = f4;
        end
    end
       
    return
    
            
    
            

    
    
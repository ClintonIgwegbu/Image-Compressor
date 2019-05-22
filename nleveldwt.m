function Y = nleveldwt(X, n)
    % NlEVELDWT Gets the n-level dwt of an image X
    % Returns a set of subimages
    
    m=length(X); Y=X;
    
    % n-stage dwt
    for i=1:n
        t=1:m; Y(t,t)=dwt(Y(t,t)); m=m/2;
    end
       
    
return

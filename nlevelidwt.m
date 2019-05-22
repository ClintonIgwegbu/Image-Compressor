function Z = nlevelidwt(Y, n)
    % NlEVELIDWT Gets the n-level dwt from a set of subimages, Y
    % Returns a reconstructed image
    
    m = length(Y) / 2^n; Z=Y;
    
    % n-stage dwt 
    for i=1:n
        m=m*2; t=1:m; 
        Z(t,t)=idwt(Z(t,t));
    end
    
return

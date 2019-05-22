function rms = get_rms_dct(step, X , N)
    
    % Gets root mean square value of reconstructed image
    
    % dct transformation matrix of size N
    CN = dct_ii(N);
    
    Y = colxfm(colxfm(X,CN)',CN)';
    
    Yq = quantise(Y, step);
   
    Z = colxfm(colxfm(Yq',CN')',CN');
    
    rms = std(X(:) - Z(:));
    
return 




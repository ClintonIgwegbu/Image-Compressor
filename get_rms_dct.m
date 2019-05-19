function rms = get_rms_dct(step, X , N)
    
    % Returns the quantisation step size that ensures the same rms value
    % as the original image, X, quantised at a step of step_X 
    
    % dct transformation matrix of size N
    CN = dct_ii(N);
    
    Y = colxfm(colxfm(X,CN)',CN)';
    
    Yq = quantise(Y, step);
   
    Z = colxfm(colxfm(Yq',CN')',CN');
    
    rms = std(X(:) - Z(:));
    
return 




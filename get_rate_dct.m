function rate = get_rate_dct(step_X, X, N, tol)
    
    step = get_optimum_step(step_X, X, 'dct', N, 0, 0, 0, tol);
    h_x = bpp(quantise(X,step_X));
    
    CN = dct_ii(N);
    Y = colxfm(colxfm(X,CN)',CN)';
    Yq = quantise(Y, step);
    Yr = regroup(Yq,N)/N;
    
    rate = dctbpp(Yr, N) / h_x;
        
return

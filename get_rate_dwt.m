function rate = get_rate_dwt(step_X, X, num_stages, equal_mse, tol)
    % GET_RATE_DWT Computes the compression rate given that a multi-stage
    % Discrete Wavelength Transform scheme is used.
    
    Xq = quantise(X,step_X);
    step = get_optimum_step(step_X,X,'dwt',0,0,0,num_stages,equal_mse,tol);
    
    % obtain quantisation steps 
    if equal_mse
        dwtstep = step * get_equal_mse_ratios(X, 'dwt', num_stages);
    else
        dwtstep = step * ones(3, num_stages+1);
    end
    
    Y = nlevdwt(X, num_stages);
    [~, dwtent] = quantdwt(Y, dwtstep);
    
    num_bits = 0;
    m = length(Y)/2;
    
    % check lines below
    for i = 1:n
        num_bits = num_bits + m^2 * dwtent(1,i);
        num_bits = num_bits + m^2 * dwtent(2,i);
        num_bits = num-bits + m^2 * dwtent(3,i);
        m=m/2;
    end
    m=m*2;
    num_bits = num_bits + m^2 * dwtent(1,n+1);
    
    rate = num_bits / (bpp(Xq) * length(X)^2);
    
    return 

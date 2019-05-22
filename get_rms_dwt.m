function rms = get_rms_dwt(step, X, num_stages)
    % GET_RMS_DWT Get the root mean squared value of the reconstructed
    % image Z after the n-level DWT transform Y has been quantised with
    % values given in dwtstep
    
    % get quantisation steps, dwtstep, where step is that of the final 
    % low_pass image
    
    if equal_mse
        dwtstep = step * get_equal_mse_ratios(X, 'dwt', num_stages);
    else
        dwtstep = step * ones(3, num_stages+1);
    end
    
    Y = nlevdwt(X, n);
    [Yq, ~] = quantdwt(Y, dwtstep);
    Z = nlevidwt(Yq, n);
    rms = std(X(:) - Z(:));
    
    return
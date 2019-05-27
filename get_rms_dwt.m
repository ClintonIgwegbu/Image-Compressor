function rms = get_rms_dwt(step, X, num_stages, equal_mse)
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
    
    Y = nleveldwt(X, num_stages);
    [Yq, ~] = quantdwt(Y, dwtstep);
    Z = nlevelidwt(Yq, num_stages);
    rms = std(X(:) - Z(:));
    
    return
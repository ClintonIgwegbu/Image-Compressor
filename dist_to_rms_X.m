function dist = dist_to_rms_X(step, step_X, X, scheme, N, h, s, num_stages, equal_mse)
    
    % DIST_TO_RMS_X Get magnitude of difference between rms values of
    % original image, X, and reconstructed image
    %
    % If dct is true then need parameter N
    % If false (pyramid) then need parameter num_stages, h and equal_mse
    
    X_discrete = quantise(X, step_X);
    rms_X = std(X(:) - X_discrete(:));
    
    
    switch scheme
        case 'dct'
            dist = abs(get_rms_dct(step, X, N) - rms_X);
            
        case 'pyramid'
            dist = abs(get_rms_pyramid(step, X, h, num_stages, equal_mse) - rms_X);
            
        case 'lbt'
            dist = abs(get_rms_lbt(step, X, N, s) - rms_X); 
            
        case 'dwt'
            
        otherwise
            % display error message
            strcat(scheme, ' is not a valid compression scheme.') 
    end 
    
return
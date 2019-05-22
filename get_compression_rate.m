function rate = get_compression_rate(step_X, X, scheme, N, h, s, num_stages, equal_mse, tol)
      
    % GET_COMPRESSION_RATE 
    % Get compression rate given that compressed data is quantised with
    % step size that gives same rms value as that of X quantised with step 
    % size step_X
    %
    % This function returns the compression rate given 
    % that an objective measure of image quality is preserved 
    
    switch scheme
        case 'dct'
            rate = get_rate_dct(step_X, X, N, tol);
            
        case 'pyramid'
            rate = get_rate_pyramid(step_X, X, h, num_stages, equal_mse, tol);
            
        case 'lbt'
            rate = get_rate_lbt(step_X, X, N, s, tol);
            
        case 'dwt'
            
        otherwise
            % display error message
            strcat(scheme, ' is not a valid compression scheme.') 
    end 
    
return 



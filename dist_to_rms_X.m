function dist = dist_to_rms_X(step, step_X, num_stages, X, h, equal_mse)

    rms_X = get_rms(step_X, 0, X, h, 0);
    dist = abs(get_rms(step, num_stages, X, h, equal_mse) - rms_X);
    
return
function step = get_optimum_step(num_stages, step_X)

    tol = 0.25;
    x1 = 1;
    x2 = 50;
    rms_X = get_rms(0, step_X);
    f = @g; 
    step = round(golden_search(g, x1, x2, tol)); 
    
return 


function g = g(num_stages, step, rms_X)
    
    g = abs(get_rms(num_stages, step) - rms_X);
    
return 
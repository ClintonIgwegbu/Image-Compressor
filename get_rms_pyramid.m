function rms = get_rms_pyramid(step, X, h, num_stages, equal_mse)
    
    % finds the root mean square value of a laplacian pyramid 
    
    if equal_mse
        ratios = get_equal_mse_ratios(X, 'pyramid', num_stages);
    else
        ratios = ones(1, num_stages);
    end
    
    step = step*ratios;
    
    % fetch sub-images up to 4 level
    [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X,h);
    
    
    % find the quantisation step for each stage
    % switch statement ensures index of step is not exceeded 
    stepA = step(1);
    stepB = 0;
    stepC = 0;
    stepD = 0;
    
    switch num_stages
        case 2
            stepB = step(2);
        case 3
            stepB = step(2);
            stepC = step(3);
        case 4
            stepB = step(2);
            stepC = step(3);
            stepD = step(4);
    end
    
    % quantise with different steps for each layer 
    X_discrete = quantise(X, step); % it IS right of me to use step here instead of step_X
    x1 = quantise(x1, stepA);
    x2 = quantise(x2, stepB);
    x3 = quantise(x3, stepC);
    x4 = quantise(x4, stepD);
    y0 = quantise(y0, stepA);
    y1 = quantise(y1, stepB);
    y2 = quantise(y2, stepC);
    y3 = quantise(y3, stepD);

    switch num_stages
        case 0
            rms = std(X(:) - X_discrete(:)); 
        case 1
            out1 = py1dec(x1,y0,h);
            rms = std(X(:) - out1(:));
        case 2
            out2 = py2dec(x2,y0,y1,h);
            rms = std(X(:) - out2(:)); 
        case 3
            out3 = py3dec(x3,y0,y1,y2,h);
            rms = std(X(:) - out3(:)); 
        case 4
            out4 = py4dec(x4,y0,y1,y2,y3,h);
            rms = std(X(:) - out4(:));
        otherwise
    end 
            
return 
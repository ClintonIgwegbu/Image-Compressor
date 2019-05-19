function rms = get_rms_pyramid(step, X, h, num_stages, equal_mse)
    
    % finds the root mean square value of a laplacian pyramid 
    
    if equal_mse
        ratios = get_equal_mse_ratios(X, num_stages);
    else
        ratios = ones(num_stages);
    end
    
    % fetch sub-images up to 4 level
    [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X,h);
    
    % if statements ensure index does not exceed size of ratios array
    % if it does we don't care about that value of step so we set it to 0
    stepA = step;
    if num_stages >= 2
        stepB = step*ratios(2);
    else
        stepB = step;
    end
    
    if num_stages >= 3
        stepC = step*ratios(3);
    else
        stepC = step;
    end
    
    if num_stages >= 4
        stepD = step*ratios(4);
    else
        stepD = step;
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
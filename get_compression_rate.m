function rate = get_compression_rate(step_X, num_stages, X , h, tol, equal_mse)
       
    % Get compression rate given that laplacian pyramid is quantised with
    % step size that gives same rms value as that of X quantised with 
    % step size step_X
    % i.e. this function returns the compression rate given that an objective
    % measure of image quality is preserved 
    
    [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X, h);
    
    step = get_optimum_step(step_X, num_stages, X , h, tol, equal_mse);
    
    if equal_mse
        ratios = get_equal_mse_ratios(num_stages, X);
    else
        ratios = ones(num_stages);
    end
    
    % if statements ensure index does not exceed size of ratios array
    % if it does we don't care about that value of step so we set it to 0
    stepA = step;
    if num_stages >= 2
        stepB = step*ratios(2);
    else
        stepB = 0;
    end
    
    if num_stages >= 3
        stepC = step*ratios(3);
    else
        stepC = 0;
    end
    
    if num_stages >= 4
        stepD = step*ratios(4);
    else
        stepD = 0;
    end
    
    % we quantise first then find the entropy 
    h_x = bpp(quantise(X,step_X));
    h_x1 = bpp(quantise(x1,stepA));
    h_x2 = bpp(quantise(x2,stepB));
    h_x3 = bpp(quantise(x3,stepC));
    h_x4 = bpp(quantise(x4,stepD));
    h_y0 = bpp(quantise(y0,stepA));
    h_y1 = bpp(quantise(y1,stepB));
    h_y2 = bpp(quantise(y2,stepC));
    h_y3 = bpp(quantise(y3,stepD));
    
    x_bits = h_x * length(X(:));
    x1_bits = h_x1 * length(x1(:));
    x2_bits = h_x2 * length(x2(:));
    x3_bits = h_x3 * length(x3(:));
    x4_bits = h_x4 * length(x4(:));
    y0_bits = h_y0 * length(y0(:));
    y1_bits = h_y1 * length(y1(:));
    y2_bits = h_y2 * length(y2(:));
    y3_bits = h_y3 * length(y3(:));
    
    switch num_stages
        case 0 % no pyramid 
            rate = 1;
        case 1
            rate = (x1_bits + y0_bits) / x_bits;
        case 2
            rate = (x2_bits + y0_bits + y1_bits) / x_bits;
        case 3
            rate = (x3_bits + y0_bits + y1_bits + y2_bits) / x_bits;
        case 4
            rate = (x4_bits + y0_bits + y1_bits + y2_bits + y3_bits) ...
                    / x_bits;
        otherwise
    end 
    
return 

% CONST. step size
% when step_X was taken to be 17, the 2-stage offered the best compression
% rate (given that image quality is preserved)
% compression rates were:

% 1-stage: 0.7418
% 2-stage: 0.7119
% 3-stage: 0.7460
% 4-stage: 0.7912
% It was noted that the laplacian pyramid did not compress but actually 
% expanded the data if the step size was too small (step size of 2 was tried)
% Generally though for higher step sizes it seems that the 2-stage pyramid
% is the best
%

% Changed algorithm and now compression rates are considerably different 
% Equal MSE
% 1-stage: 0.7418
% 2-stage: 0.6648
% 3-stage: 0.6455
% 4-stage: 0.6397
% continued improvement under equal MSE as no. stages increased
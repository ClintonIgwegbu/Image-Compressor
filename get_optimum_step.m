function step = get_optimum_step(step_X, X, scheme, N, h, s, num_stages, equal_mse, tol)
    
    % Returns the quantisation step size that ensures the same rms value
    % as the original image, X, quantised at a step of step_X 
    % num_stages is size of laplacian pyramid or dwt 
    % h is filter; low tol gives a more accurate search
    % boolean equal_mse boolean indicates whether equal_mse criterion or
    % const. step size should be used
    
    % initial step sizes for golden search 
    x1 = 1; 
    x2 = 50;
    
    % switch statement ensures user does not need to enter redundant
    % arguments 
    switch scheme
        case 'pyramid'
            if nargin <= 8
                s = 0; 
            end
        case 'dct'
            if nargin <= 5
                h = 0;
                s = 0; 
                equal_mse = 0;
                num_stages = 0; 
            end
        case 'lbt'
            if nargin <= 6
                h = 0; 
                num_stages = 0; 
                equal_mse = 0; 
            end 
        case 'dwt'
            if nargin <= 7
                h = 0;
                s = 0;
            end 
    end 
    
    step_X;
    X; 
    scheme; 
    N;
    h;
    s;
    num_stages;
    equal_mse;
    tol;
    
    % pass function as argument only varying parameter, step
    f = @(step) dist_to_rms_X(step, step_X, X, scheme, N, h, s, num_stages, equal_mse); % objective function
    
    step = golden_search(f, x1, x2, tol);
    
    if strcmp(scheme, 'pyramid')
        if equal_mse == 1
            step = step * get_equal_mse_ratios(X,'pyramid',num_stages);
            step(2,num_stages+1)=0; step(3,num_stages+1)=0;
        else
            step = step * ones(1, num_stages);
            step(2,num_stages+1)=0; step(3,num_stages+1)=0;
        end
        
    elseif strcmp(scheme, 'dwt')
        if equal_mse == 1
           step = step * get_equal_mse_ratios(X,'dwt',num_stages);
           step(2,num_stages+1)=0; step(3,num_stages+1)=0;
        else
           step = step * ones(3,num_stages+1);
           step(2,num_stages+1)=0; step(3,num_stages+1)=0; 
        end
            
    end    
    
return 





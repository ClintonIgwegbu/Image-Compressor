function step = get_optimum_step(step_X, num_stages, X , h, tol, equal_mse)
    
    % Returns the quantisation step size that ensures the same rms value
    % as the original image, X, quantised at a step of step_X 
    % num_stages indicates the number of layers in the laplacian pyramid
    % h is the filter used and low tol gives a more accurate search
    % equal_mse is a boolean indicating whether equal_mse criterion or
    % const. step size should be used
    % if equal_mse is used then the step size for layer 0 is used - others
    % may be obtained using this step size and get_equal_mse_ratios
    
    x1 = 1; 
    x2 = 50;
    
    % handler below allows passing of function dist_to_rms_X as an argument
    % to golden_search with the parametr step being the only variable
    % dist_to_rms_X is the objective function with variable, step.
    f = @(step) dist_to_rms_X(step, step_X, num_stages, X, h, equal_mse); % objective function
    
    step = golden_search(f, x1, x2, tol); 
    
return 

% CONST. step size 
% For direct quantisation using step size of 17 the following optimum step
% sizes were obtained for pyramids of various stages:
% 1-stage: 15.5562
% 2-stage: 13.4917
% 3-stage: 11.8081
% 4-stage: 10.4716
% i.e. for larger pyramids we need to quantise more finely to obtain the 
% same quantisation error as directly quantising - makes sense since we 
% expect errors to accummulate in larger pyramids due to use of more
% sub-images

% why do I get different answers than those above when repeated with new
% implementation that allows equal MSE flexibility
% Now I get the same results. Somehow the value of X changed giving me
% different results. MUST KEEP A CLOSE EYE ON THIS - my code may be
% changing X
% Equal MSE for step size of 17 in the direct quantisation 
% 1-stage: 15.5562 - same as above, as expected 
% 2-stage: [16.9852 11.3235]
% 3-stage: [17.8184 11.8789 6.4794]
% 4-stage: [18.2145 12.1430 6.6234 3.3887]



h = [0.25 0.5 0.25];
% step_X, num_stages, X , h, tol
get_optimum_step(17, 5, X, h, 0.00001)
% x1 = 1;
% x2 = 50;
% tol = 0.001;
% f = @(step) dist_to_rms_X(step, X, h); 
% step = golden_search(f, x1, x2, tol)

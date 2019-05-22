function [Yq, dwtent] = quantdwt(Y, dwtstep)
    % QUANTDWT Returns the quantised DWT transformed image Yq from the DWT
    % transform Y and the quantisation matrix dwtstep.
    
    m = length(Y)/2;
    Yq=Y; % initialise Yq
    dwtent = dwtstep; % initialise dwtent
    n = size(dwtstep) - 1; % num stages of DWT
    
    % quantise each highpass image according to step defined in dwtstep
    % then store entropies 
    for i = 1:n
        t=1:m;
        Yq(t,t+m) = quantise(Y, dwtstep(1,i)); dwtent(1,i) = bpp(Yq(t,t+m));
        Yq(t+m,t) = quantise(Y, dwtstep(2,i)); dwtent(2,i) = bpp(Yq(t+m,t));
        Yq(t+m,t+m) = quantise(Y, dwtstep(3,i)); dwtent(3,i) = bpp(Yq(t+m,t+m));
        m=m/2; 
    end
    
    % quantise final lowpass image then store its entropy
    t=1:m; 
    Yq(t,t) = quantise(Y, dwtstep(1,n+1)); dwtent(1,n+1) = bpp(Yq(t,t));
    
    
return 
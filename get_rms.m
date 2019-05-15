function rms = get_rms(num_stages, step)
    
    % fetch sub-images up to 4 level
    [x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X,h);
    
    % quantise 
    X_discrete = quantise(X, step);
    x1 = quantise(x1, step);
    x2 = quantise(x2, step);
    x3 = quantise(x3, step);
    x4 = quantise(x4, step);
    y0 = quantise(y0, step);
    y1 = quantise(y1, step);
    y2 = quantise(y2, step);
    y3 = quantise(y3, step);

    switch num_stages
        case 0
            rms = std(X(:) - X_discrete(:)); 
        case 1
            out1 = py1dec(x1,y0,h);
            rms = std(X(:) - out1(:));
        case 2
            out2 = py2dec(x2,y1,y0,h);
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
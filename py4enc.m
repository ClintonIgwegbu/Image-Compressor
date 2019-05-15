function [x4,y0,y1,y2,y3] = py4enc(X, h)
    
    % encodes an image into a set of 4 high-pass images and 
    % a 1/256 size low-pass image 
    
    x1 = rowdec(rowdec(X, h)', h)';
    x2 = rowdec(rowdec(x1, h)', h)';
    x3 = rowdec(rowdec(x2, h)', h)';
    x4 = rowdec(rowdec(x3, h)', h)';

    y0 = X - rowint(rowint(x1, 2*h)', 2*h)';
    y1 = x1 - rowint(rowint(x2, 2*h)', 2*h)';
    y2 = x2 - rowint(rowint(x3, 2*h)', 2*h)';
    y3 = x3 - rowint(rowint(x4, 2*h)', 2*h)';
    
return 
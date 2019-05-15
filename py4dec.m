function z = py4dec(x4,y0,y1,y2,y3,h)
    
    % Decodes a set of encoded image data to retrieve
    % the original image 

    z3 = y3 + rowint(rowint(x4, 2*h)', 2*h)';
    z2 = y2 + rowint(rowint(z3, 2*h)', 2*h)';
    z1 = y1 + rowint(rowint(z2, 2*h)', 2*h)';
    z = y0 + rowint(rowint(z1, 2*h)', 2*h)'; 

return
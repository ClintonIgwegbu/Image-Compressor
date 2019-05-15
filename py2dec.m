function z = py2dec(x2,y1,y0,h)

    z1 = y1 + rowint(rowint(x2, 2*h)', 2*h)';
    z = y0 + rowint(rowint(z1, 2*h)', 2*h)';
    
return 
function z = py3dec(x3,y0,y1,y2,h)

    z2 = y2 + rowint(rowint(x3, 2*h)', 2*h)';
    z1 = y1 + rowint(rowint(z2, 2*h)', 2*h)';
    z = y0 + rowint(rowint(z1, 2*h)', 2*h)';
    
return 
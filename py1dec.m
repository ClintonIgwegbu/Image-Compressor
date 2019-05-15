function z = py1dec(x1, y0, h)

    z = y0 + rowint(rowint(x1, 2*h)', 2*h)';

return
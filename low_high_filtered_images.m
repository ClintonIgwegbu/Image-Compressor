hcf5 = halfcos(5);
hcf15 = halfcos(15);
hcf25 = halfcos(25);
hcf35 = halfcos(35);

% these are row, then column filtered 
% low-pass
Xl5 = convse(convse(X, hcf5)', hcf5)';
Xl15 = convse(convse(X, hcf15)', hcf15)';
Xl25 = convse(convse(X, hcf25)', hcf25)';
Xl35 = convse(convse(X, hcf35)', hcf35)';

% high-pass 
Xh5 = X - Xl5;
Xh15 = X - Xl15;
Xh25 = X - Xl25;
Xh35 = X - Xl35;

% low-pass filtered image seems to be brightened when displayed this way 
% draw
figure(1)
draw([Xl5 Xh5])

figure(2)
draw([Xl15 Xh15])

figure(3)
draw([Xl25 Xh25])

figure(4)
draw([Xl35 Xh35])

% energy in each image
El5 = sum(Xl5(:).^2);
Eh5 = sum(Xh5(:).^2);
El15 = sum(Xl15(:).^2);
Eh15 = sum(Xh15(:).^2);
El25 = sum(Xl25(:).^2);
Eh25 = sum(Xh25(:).^2);
El35 = sum(Xl35(:).^2)
Eh35 = sum(Xh35(:).^2)

% low pass images have about 18 to 50 times the energy of high-pass ones -
% the lower range is for larger filters and higher range for smaller
% filters

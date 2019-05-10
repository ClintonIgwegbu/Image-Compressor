hcf5 = halfcos(5);
hcf10 = halfcos(10);
hcf15 = halfcos(15);
hcf20 = halfcos(20);
hcf30 = halfcos(30);

% these are row, then column filtered 
% low-pass
Xl5 = convse(convse(X, hcf5)', hcf5)';
Xl10 = convse(convse(X, hcf10)', hcf10)';
Xl15 = convse(convse(X, hcf15)', hcf15)';
Xl20 = convse(convse(X, hcf20)', hcf20)';
Xl30 = convse(convse(X, hcf30)', hcf30)';

% these are row, then column filtered 
% high-pass 
Xh5 = X - Xl5;
Xh10 = X - Xl10;
Xh15 = X - Xl15;
Xh20 = X - Xl20;
Xh30 = X - Xl30;

% low-pass filtered image seems to be brightened when displayed this way 
% draw
figure(1)
draw([Xl5 Xh5])

figure(2)
draw([Xl10 Xh10])

figure(3)
draw([Xl15 Xh15])

figure(4)
draw([Xl20 Xh20])

figure(5)
draw([Xl30 Xh30])


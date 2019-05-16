
h = 1/4*[1 2 1];

% draw(beside(y0,beside(y1,beside(y2,beside(y3,x4)))))

% Getting information needed for report - pyenc (not py4enc) was
% defined for this purpose as well as pyienc where i is not 4 
[x1,x2,x3,x4,y0,y1,y2,y3] = pyenc(X,h);

% quantise pyramid 
step = 17;

X_discrete = quantise(X, step);
x1 = quantise(x1, step);
x2 = quantise(x2, step);
x3 = quantise(x3, step);
x4 = quantise(x4, step);
y0 = quantise(y0, step);
y1 = quantise(y1, step);
y2 = quantise(y2, step);
y3 = quantise(y3, step);

out1 = py1dec(x1,y0,h); % decoder output for single stage pyramid 
out2 = py2dec(x2,y0,y1,h);
out3 = py3dec(x3,y0,y1,y2,h);
out4 = py4dec(x4,y0,y1,y2,y3,h);

draw(out4)

std1 = std(X(:) - out1(:))
std2 = std(X(:) - out2(:))
std3 = std(X(:) - out3(:))
std4 = std(X(:) - out4(:))

std_X = std(X(:) - X_discrete(:))

% Compare original image to discretised version and discretised output of
% 4-stage encoding process  
figure(1)
draw(X)
figure(2)
draw(X_discrete)
figure(3)
draw(out1)


% above the laplacian pyramid was quantised then an attempt was made
% to reconstruct the original image from the quantised image
% Visual artefacts observed: clouds are unclear now 
% 4-stage std = 7.7572
% 3-stage std = 6.9232
% 2-stage std = 6.0639
% 1-stage std = 5.4165
% std for discretised orignal is 4.9340
% RMS errors are larger in the pyramid scheme because the quantisation 
% errors accummulate from all the intermediate images that are summed

% 40stage 




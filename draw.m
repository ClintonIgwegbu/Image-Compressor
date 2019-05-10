function draw(data, map);

% DRAW Draw an image
% 
%  DRAW(D, M) displays D as an image with colormap M.
%  If M is not given, greyscale is assumed.

% ensure we have the right input parameters
error(nargchk(1,2, nargin, 'struct'));
if (nargin==1) % if only one input argument given (no map)
  map = [0:255]'*ones(1,3)*(1/255); % use grey scale map 
end

% adjust by an appropriate multiple of 128
image(data-128*round(min(data(:))/128));

% draw image in current figure
axis image;  % equal aspect ratio
axis off;       % no axes
set(gca,'Position',[0 0 1 1]); % fill the figure
set(gcf,'Color',[0 0 0]);        % black surround
colormap(map); % sets the current figure's colour map to map 

% [0:255]' is a column vector while ones(1,3) is a row vector - multiplying
% these as given in if statement creates a 256 by 3 matrix 
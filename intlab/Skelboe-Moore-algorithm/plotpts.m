function plotpts(pts,varargin)
% RBK 2007/02/13 -- From Siripawn Winter's dissertation project 00
%   plotpts([p1;p2;...;pn])
% plots points p1,p2,...,pn which are *row* vectors of length 2 or 3
%
% By default the points are connected by lines. To get a closed polygon, repeat
% the first point: plotpts([p1;p2;...;pn;p1])
%
% You can get different styles by using an additional argument:
%   plotpts([p1;p2;...;pn],'o')
% plots the points as small circles, and does not connect them,
%   plotpts([p1;p2;...;pn],'r*:')
% plots the points as red stars, and connects them with a dotted line.
% Type   help plot   for more options.
d = size(pts,2);
if d==2
  plot(pts(:,1),pts(:,2),varargin{:});
elseif d==3
  plot3(pts(:,1),pts(:,2),pts(:,3),varargin{:});
else
  error('rows must have length 2 or 3')
end


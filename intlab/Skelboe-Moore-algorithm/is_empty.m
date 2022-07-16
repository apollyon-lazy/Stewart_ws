function [it_is] = is_empty(list);
% [it_is] = is_empty(list) returns 1 if list
% is empty and returns 0 otherwise.

% Ralph Baker Kearfott, 2008/06/14 -- for the 
% Moore / Kearfott /  Cloud book.

if (list(1).next)
    it_is = 0;
else
    it_is = 1;
end
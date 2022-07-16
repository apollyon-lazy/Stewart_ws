function [ivl] = rigorinfsup(x,y)
% [ivl] = rigorinfsup(x,y) returns an interval whose internal
% representation contains a rigorous enclosure for the
% decimal strings x and y. It is an error to call this function
% if the arguments are not character.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

if (ischar(x) & ischar(y))
    ilower = intval(x);
    iupper = intval(y);
    ivl = infsup(inf(ilower), sup(iupper));
else
    display('Error in rigorinfsup; one of arguments is not');
    display('a character string.');
    ivl = infsup(-Inf, Inf);
end;
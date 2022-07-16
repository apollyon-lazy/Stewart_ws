function it_is = is_a_proper_subset(KX,X)
% it_is = is_a_proper_subset(KX,X) returns "1" if
% the interval vector KX is a proper subset of X, and returns
% "0" otherwise.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

n = length(X);
contained = 1;
it_is = 0;
i=1;
while contained & i<=n
    if (inf(KX(i)) < inf(X(i))) | (sup(KX(i)) > sup(X(i)))
        contained = 0;
        it_is = 0;
    elseif (inf(KX(i)) > inf(X(i))) | (sup(KX(i)) < sup(X(i)))
        it_is = 1;
    end
    i = i+1;
end
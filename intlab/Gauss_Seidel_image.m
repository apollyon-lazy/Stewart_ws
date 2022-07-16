function [X_kp1,is_empty, error_occurred] =...
    Gauss_Seidel_image(A, B, X_k)
% X_kp1] = Gauss_Seidel_image(A,B,X_k) returns the image after a
% sweep of Gauss--Seidel iteration ( that is, (7.8) of the text)
% for the interval linear system A X = B, beginning with box X_k,
% 1 <= i <= n.
% This is done using the inverse midpoint preconditioner.
% Upon return:
% if error_occurred = 1, then the computation could not proceed.
% (For example, the midpoint preconditioner may have been
% singular, or the denominator may have contained zero; the
% case of more than one box in the image is not handled
% with this routine.) Otherwise, error_occurred = 0.
% If error_occurred = 0 but is_empty = 1, this means that
% an intersection of a coordinate extent was empty.  In this
% case, there are no solutions to A X = B within X_k.
% If error_occurred = 0 and is_empty = 0, then the image under
% the Gauss--Seidel sweep is returned in X_kp1.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

n = length(B);
Y = inv(mid(A));

error_occurred = 0;
is_empty = 0;
i=1;
X_kp1 = midrad(zeros(n,1),0);
while(~error_occurred & ~is_empty & i<= n)
    [new_x_i, second_new_x_i, there_are_2, num, denom] ...
        = gauss_seidel_step(i, Y(i,:), A, B, X_k);
    if(there_are_2)
        error_occurred = 1;
    end
    if (~error_occurred)
        is_empty = isempty_(intersect(new_x_i,X_k(i)));
        if (~is_empty)
            X_kp1(i) = intersect(new_x_i, X_k(i));
        end
    end
    i=i+1;
end


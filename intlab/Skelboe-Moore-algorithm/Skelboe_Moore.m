function [LB, X_lb, N_iter, completed_list]...
             = Skelboe_Moore (f, X0, epsilon)
% [LB, X_lb, N_iter, completed_list]...
%              = Skelboe_Moore (f, X0, epsilon)
% implements the Skelboe -- Moore algorithm in Chapter 6
% of Moore / Kearfott / Cloud.  f is the function handle
% for the objective, while X0 is the starting box, and
% epsilon is the tolerance by which the returned lower bound
% can fail to be sharp. 
% On return --
%   LB is the mathematically rigorous lower bound on
%     f over X0.
%   X_lb is a box over which this lower bound has
%      been computed by interval evaluation of f.
%   N_iter is the number of bisections that were done
%      to complete the computation.
%   completed_list is the linked list of boxes produced
%      during the subdivision process.  It may be plotted
%      using "plot_list."
% It is assumed that X0 is an interval column vector.
%
% Caution: setting epsilon too small
% can cause an infinite loop.  This can be avoided by
% modifying this routine to set a limit on the number
% of iterations.  In that case, a valid lower bound
% will be returned, but it may not be sharp to within
% epsilon.

% Ralph Baker Kearfott, 2008/06/14 -- for the 
% Moore / Kearfott /  Cloud book.

% ml_to_do and ml_completed are the total current amounts of
% storage allocated for the to_do list and completed_list,
% respectively --

ml_d = 1000;
ml_c = 1000;

% Steps 1 and 2 --
X = X0;
midX = mid(X);
fbar = sup(feval(f, midrad(midX,0)));
N_iter = 0;

% Step 3 --
[to_do_list,ffi_d] = new_linked_list(ml_d,X0);
[completed_list,ffi_c] = new_linked_list(ml_c,X0);
is_first = 1;

% Step 4 --
while(~is_empty(to_do_list) | is_first)
N_iter = N_iter + 1;
is_first = 0;
X; % Remove the ";" to print "X" on each iteration.
[X1,X2] = bisect(X);

% Step 5 --
M1 = midrad(mid(X1),0);
FM1 = feval(f,M1);
M2 = midrad(mid(X2),0);
FM2 = feval(f,M2);
ub1 = sup(FM1);
ub2 = sup(FM2);
fbar = min(fbar,ub1);
fbar = min(fbar,ub2);

% Step 6 --
F1 = feval(f,X1);
F2 = feval(f,X2);
if max(sup(F1),sup(F2)) - min(inf(F1),inf(F2)) < epsilon
    [completed_list,ml_c,ffi_c] = insert ...
        (completed_list, ml_c, ffi_c, X1, inf(F1));
    [completed_list,ml_c,ffi_c] = insert ...
        (completed_list, ml_c, ffi_c, X2, inf(F2));
    if (~is_empty(to_do_list))
        [X,lb_X,to_do_list,ffi_d] = remove_first...
            (to_do_list,ml_d,ffi_d);
        if (lb_X > fbar)
            [X_lb,LB,completed_list,ffi_c] = remove_first...
                (completed_list,ml_c,ffi_c);
            [completed_list,ml_c,ffi_c] = insert ...
                (completed_list, ml_c, ffi_c, X_lb, LB);
            while (~is_empty(to_do_list))
                [X,lb,to_do_list,ffi_d] = remove_first...
                    (to_do_list,ml_d,ffi_d);
                [completed_list,ml_c,ffi_c] = insert...
                    (completed_list, ml_c, ffi_c, X, lb);
            end
            % Store lower bound in an interval so it will 
            % print with correct rounding --
            LB = midrad(LB,0);
            return
        end
    else
        [X_lb,LB,completed_list,ffi_c] = remove_first...
            (completed_list,ml_c,ffi_c);
        LB = midrad(LB,0);
        [completed_list,ml_c,ffi_c] = insert ...
            (completed_list, ml_c, ffi_c, X_lb, LB);
        return
    end
else
    [to_do_list,ml_d,ffi_d] = insert ...
        (to_do_list, ml_d, ffi_d, X1, inf(F1));
    [to_do_list,ml_d,ffi_d] = insert ...
        (to_do_list, ml_d, ffi_d, X2, inf(F2));
    [X,lb_X,to_do_list,ffi_d] = remove_first...
        (to_do_list,ml_d,ffi_d);
end
% Step 7 (control is implemented as a "while" loop)
end %while
 
            
        
        




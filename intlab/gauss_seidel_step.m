function [new_X_i, second_new_X_i, there_are_2,...
    numerator, denominator]...
    = gauss_seidel_step(i, Y_i, A, B, X)
% [new_X_i, second_new_X_i, there_are_2]...
%  = gauss_seidel_step(i, Y_i, A, B, X) returns
% the result of applying a Gauss--Seidel step with variable i,
% preconditioner matriX Y_i, and initial guess X.  The variable
% there_are_2 is set to 1 if two semi-infinite intervals are returned,
% in which case second_new_X_i has the second interval;  there_are_2
% is set to 0 and second_new_X_i is not set if there is only
% one interval returned.

% Ralph Baker Kearfott, 2008/06/15 -- for the
% Moore / Kearfott / Cloud book.

   n = size(A,2);
   G_i = Y_i*A;
   C_i = Y_i*B;
   numerator = C_i;
   new_X_i = X(i);
   second_new_X_i = X(i);
   if (n > 1)
       if (i > 1)
           numerator = numerator - G_i(1:i-1)*X(1:i-1);
       end
       if (i < n)
          numerator = numerator - G_i(i+1:n)*X(i+1:n);
       end
   end
   denominator = G_i(i);
   numerator;
   denominator;
   if (~in(0,denominator))
       there_are_2 = 0;
       new_X_i = numerator / denominator;
   elseif (~in(0,numerator))
       there_are_2 = 1;
       supnum = sup(numerator);
       if(supnum < 0)
           if sup(denominator)==0
               tmp1 = infsup(-Inf,-Inf);
           else
               tmp1 = midrad(supnum,0) / midrad(sup(denominator),0);
           end
           if inf(denominator) == 0
               tmp2 = infsup(Inf,Inf);
           else
               tmp2 = midrad(supnum,0) / midrad(inf(denominator),0);
           end
           new_X_i = infsup(-Inf,sup(tmp1));
           second_new_X_i = infsup(inf(tmp2),inf);
       else
           infnum = inf(numerator);
           if inf(denominator)==0
               tmp1 = infsup(-Inf,-Inf)
           else
               tmp1 = midrad(infnum,0) / midrad(inf(denominator),0);
           end
           if sup(denominator) == 0
               tmp2 = infsup(Inf,Inf)
           else
               tmp2 = midrad(infnum,0) / midrad(sup(denominator),0);
           end
           new_X_i = infsup(-Inf,sup(tmp1));
           second_new_X_i = infsup(inf(tmp2),Inf);
       end
   else
       there_are_2=0;
       new_X_i = infsup(-Inf,Inf);
   end
end





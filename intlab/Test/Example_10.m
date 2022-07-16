% format long;
% Y = 1e-4*[6 3;3 6];
% b = [10;-5];
% A = [infsup(1800,2200) infsup(-1100,-900);...
%     infsup(-1100,-900) infsup(1800,2200)];
% E = eye(2)-Y*A;
% X0 = norm(Y*b)/(1-norm(E));
% X0 = X0*[infsup(-1,1);infsup(-1,1)];
% display(X0);

%% INTLAB note: norm
% norm 默认是二范数计算
A = [infsup(1,2) infsup(-1,0);...
    infsup(-1,1) infsup(1,2)];
C = [infsup(1,3) infsup(2,4) infsup(0,2)]';
B = norm(A);
B2 = norm(C);
display(B);
display(B2);
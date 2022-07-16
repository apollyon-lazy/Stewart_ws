function y = acoss(x)
    if isintval(x)
        a = acos(inf(x)); % 下界
        b = acos(sup(x)); % 上界
        if ~isreal(a)
            a = acos(-1);
        end
        if ~isreal(b)
            b = 0;
        end
    y = infsup(b,a);
    else
        y = acos(x);
    end
end
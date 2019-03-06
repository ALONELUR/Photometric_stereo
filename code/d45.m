function output = d45(n,m)
    %myFun - Description
    %
    % Syntax: output = d45(n)
    %
    % Long description
    % if (n(2)-n(3)==0)
    %     output=0;
    % else
    %     output=sqrt(2)*n(1)/(n(2)-n(3));
    % end
    m=m./norm(m);
    touyin=n-(n'*m).*m;
        output=-([0,m(3),-m(2)]*touyin)/([1,0,0]*touyin);
end
function output = tousheX(n)
    %myFun - Description
    %
    % Syntax: output = tousheY(n)
    %
    % Long description
    n=[n(3);0;-n(1)];
    output=n./norm(n);
    
    end
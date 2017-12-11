function [str_poly] = poly2string(u)
% Input polynomial vector to get string
% e.g. [2 -1 4] gives  2*x^2 -x + 4
str_poly='';
for i=1:length(u)
    if(u(i)>0 && i>1)
        str_poly=strcat(str_poly,(' + '));
    elseif(u(i)<0)
        str_poly=strcat(str_poly,(' - '));
    end
    if(abs(u(i))~=1 && u(i)~=0)
        str_poly=strcat(str_poly,num2str(abs(u(i))));
    end
    if((u(i)==1 || u(i)==-1) && i==length(u))
        str_poly=strcat(str_poly,num2str((abs(u(i)))));
    end
    if(u(i)~=0 && i<length(u))
        str_poly=strcat(str_poly,('x'));
    end
    if((length(u)-i)>1 && u(i)~=0)
        str_poly=strcat(str_poly,'^',num2str((length(u)-i)));
    end
end
end

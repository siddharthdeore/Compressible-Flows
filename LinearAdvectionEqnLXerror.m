clear all;
close all;
clc;

% Realtime simulation of LAE using numerical schemes
% iScheme = 1 ==> FTCS
% iScheme = 2 ==> LF
% iScheme = 3 ==> FTFS
% iScheme = 4 ==> FTBS
%iScheme = input('select scheme ');

sigma=0.5;
c=1;
errglob=[0 0 0 0 0 0 0];
for count=5:11
    elapseT=0;
    NX=2^count - 1;
    dx = 1/NX;  % defination of mesh spaceingerrglob(4) = 0
    dt=dx*sigma/c;
    x=0:(1/(NX)):1;
    ue=sin(4*pi.*x).^2;
    un=ue;
    while(elapseT<1)
        elapseT=elapseT+dt;
        unp(1)=un(1) - 0.5*sigma*(un(1)-un(NX));
        for j=2:NX
            unp(j)=un(j) - 0.5*sigma*(un(j)-un(j-1));
        end
        unp(NX+1)=un(NX+1) - 0.5*sigma*(un(NX+1)-un(NX));
        un=unp;
    end
    
    %Calculate Error
    for j=1 : NX+1
        errglob(count-4) = errglob(count-4) + (ue(j)-un(j))^2;
    end
    errglob(count-4) = errglob(count-4)/(NX+1);
    errglob(count-4) = sqrt(errglob(count-4));
    
    
    hold on
    cla;
    title(strcat('Number of Nodes=(',num2str(NX),') Error = ',num2str(errglob(count-4))));
    xlabel('x');
    ylabel('sin(4*\pi*x)^{2}');
    plot(x,unp,'LineWidth',2);
    plot(x,ue,'LineWidth',2);
    pause(1);
end
errglob
clear all;
close all;
clc;

% Realtime simulation of LAE using numerical schemes
% iScheme = 1 ==> FTCS
% iScheme = 2 ==> LF
% iScheme = 3 ==> FTFS
% iScheme = 4 ==> FTBS
iScheme = input('select scheme ');

NX = 140;    % Number of subintervals for discretisation. |--!--!--!--| 40 nodes!
dx = 1/NX;  % defination of mesh spaceing

for j=1:NX+1
    x(j) =(j-1)*dx;         % discreetization in Space Direction
    ue(j)=sin(4*pi*x(j))^2; % waveform t for time=0 
    un(j)=ue(j);
end
sigma=0.5;
c=1;
dt=dx*sigma/c;
elapseT=0;
while(elapseT<1)
    elapseT=elapseT+dt;
    
    % FTCS %
    if iScheme==1
        unp(1)=un(1) - 0.5*sigma*(un(2)-un(NX));
        for j=2:NX
            unp(j)=un(j) - 0.5*sigma*(un(j+1)-un(j-1));
        end
        unp(NX+1)=un(NX+1) - 0.5*sigma*(un(2)-un(NX));
        un=unp;
    elseif iScheme==2 %LF
        unp(1)=un(1) - 0.5*sigma*(un(2)-un(NX));
%        unp(1)=0.5*(un(NX+1)+un(2)) - 0.5*sigma*(un(2)-un(NX+1));
        for j=2:NX
            unp(j)=0.5*(un(j-1)+un(j+1)) - 0.5*sigma*(un(j+1)-un(j-1));
        end
        unp(NX+1)=un(NX+1) - 0.5*sigma*(un(2)-un(NX));
%        unp(NX+1)=0.5*(un(NX)+un(1)) - 0.5*sigma*(un(1)-un(NX));
        un=unp;
        % Todo: Remove disturbances in scheme 3 %
    elseif iScheme==3 %FTFS    
        unp(1)=un(1) - 0.5*sigma*(un(2)-un(1));
%        unp(1)=un(1)-0.5*sigma*(un(2)-un(1));
        for j=2:NX
            unp(j)=un(j) - 0.5*sigma*(un(j+1)-un(j));
        end
        unp(NX+1)=un(NX+1) - 0.5*sigma*(un(1)-un(NX+1));
%        unp(NX+1)=un(NX+1)-0.5*sigma*(un(2)-un(NX+1));
        un=unp;
    elseif iScheme==4 %FTBS
        unp(1)=un(1) - 0.5*sigma*(un(2)-un(NX));
%        unp(1)=un(1)-0.5*sigma*(un(1)-un(NX+1));
        for j=2:NX
            unp(j)=un(j) - 0.5*sigma*(un(j)-un(j-1));
        end
        unp(NX+1)=un(NX+1) - 0.5*sigma*(un(2)-un(NX));
%        unp(NX+1)=un(NX+1)-0.5*sigma*(un(NX+1)-un(NX));
        un=unp;
    else 
    end
    
hold on
cla
plot(x,unp)
plot(x,ue)
pause(0.001)
end
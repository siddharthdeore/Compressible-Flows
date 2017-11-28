clear all;
close all;
clc;

% Realtime simulation of LAE using numerical schemes
% iScheme = 1 ==> FTCS
% iScheme = 2 ==> LF
% iScheme = 3 ==> FTFS
% iScheme = 4 ==> FTBS
%iScheme = input('select scheme ');

NX = 63;    % Number of subintervals for discretisation. |--!--!--!--| 40 nodes!
dx = 1/NX;  % defination of mesh spaceingerrglob(4) = 0
errglob(4)=0;
for j=1:NX+1
    x(j) =(j-1)*dx;         % discreetization in Space Direction
    ue(j)=sin(4*pi*x(j))^2; % waveform t for time=0
end
un=ue;
sigma=0.5;
c=1;
dt=dx*sigma/c;
for iScheme=1:4
    elapseT=0;
    un=ue;
    while(elapseT<1)
        elapseT=elapseT+dt;
        
        % FTCS %
        if iScheme==1
            SchemeName='Scheme 1: FTCS';
            unp(1)=un(1) - 0.5*sigma*(un(2)-un(NX));
            for j=2:NX
                unp(j)=un(j) - 0.5*sigma*(un(j+1)-un(j-1));
            end
            unp(NX+1)=un(NX+1) - 0.5*sigma*(un(2)-un(NX));
            un=unp;
        elseif iScheme==2 %LF
            SchemeName='Scheme 2: LF';
            unp(1)=0.5*(un(NX)+un(2)) - 0.5*sigma*(un(2)-un(NX));
            for j=2:NX
                unp(j)=0.5*(un(j-1)+un(j+1)) - 0.5*sigma*(un(j+1)-un(j-1));
            end
            unp(NX+1)=0.5*(un(NX)+un(2)) - 0.5*sigma*(un(2)-un(NX));
            un=unp;
            % Todo: Remove disturbances in scheme 3 %
        elseif iScheme==3 %FTFS
            SchemeName='Scheme 3: FTFS';
            unp(1)=un(1) - 0.5*sigma*(un(2)-un(1));
            for j=2:NX
                unp(j)=un(j) - 0.5*sigma*(un(j+1)-un(j));
            end
            unp(NX+1)=un(NX+1) - 0.5*sigma*(un(2)-un(NX+1));
            un=unp;
        elseif iScheme==4 %FTBS
            SchemeName='Scheme 4: FTBS';
            unp(1)=un(1) - 0.5*sigma*(un(1)-un(NX));
            for j=2:NX
                unp(j)=un(j) - 0.5*sigma*(un(j)-un(j-1));
            end
            unp(NX+1)=un(NX+1) - 0.5*sigma*(un(NX+1)-un(NX));
            un=unp;
        else
        end
        
        %Calculate Error
        for j=1 : NX+1
            errglob(iScheme) = errglob(iScheme) + (ue(j)-un(j))^2;
        end
        errglob(iScheme) = errglob(iScheme)/(NX+1);
        errglob(iScheme) = sqrt(errglob(iScheme));
        dxlist(iScheme)=dx;
        
        
        hold on
        cla;
        title(SchemeName);
        xlabel('x');
        xlabel(strcat('time= ',num2str(elapseT),'s'));
        ylabel('sin(4*\pi*x)^{2}');
        plot(x,unp,'LineWidth',2);
        plot(x,ue,'LineWidth',2);
        %        legend('Exact Solution','Numerical Solution')
        pause(0.0001);
    end
    pause(1);
end

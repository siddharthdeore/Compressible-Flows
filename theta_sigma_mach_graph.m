clc;
clear all;
close all;
gamma=1.4;
% set of mach numbers
m=[1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.25 2.5 3.0 3.5 4.5 6.0 15];
% shock angle sigma varies from 0 to 90 degree
sigma=linspace(0,pi/2,30);
for j=1:30;
    for i=1:length(m);
        % deflaction angle theta
        theta(j,i)=atan((2*cot(sigma(j)))*(m(i)^2*sin(sigma(j))^2-1)/(m(i)^2*(gamma+cos(2*sigma(j)))+2));
    end
end
theta=theta.*180/pi;
sigma=sigma.*180/pi;
plot(theta,sigma);
title('Shock wave \sigma - Deflaction angle \theta - Mach number relation');
xlabel('Deflection angle \theta');
ylabel('Wave angle \beta');
legend(strsplit(num2str(m)));
xlim([0 60]);
grid minor;

clc;
clear all;
close all;
% program to compute first order finite derivative of flux function
% method - forward diffrence

%building the mesh

a=0;			%	left extreme
b=1;			%	right extreme

N=50;  		%	number of nodes
dx=(b-a)/N; 	% mesh spacing

for i = 1 : N+1
    x(i)=a+(i-1)*dx;
    f(i) = sin(4*pi*x(i));
    dfdxe(i) = 4*pi*cos(4*pi*x(i));
end
for i = 1:N
    dfdx(i)=(f(i+1)-f(i))/dx;
end
dfdx(N+1)=dfdx(N);

plot(x,dfdx,'--r');
hold on;
plot(x,dfdxe,'-k');

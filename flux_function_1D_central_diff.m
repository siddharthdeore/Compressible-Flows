clc;
clear all;
close all;
% program to compute first order finite derivative of flux function
% using Central diffrence method

%building the mesh

a=0;			%	left extreme
b=1;			%	right extreme

N=50;  		%	number of nodes
dx=(b-a)/N; 	% mesh spacing
dfdx=0;
for i = 1 : N+1
    x(i)=a+(i-1)*dx;
    f(i) = sin(4*pi*x(i));
    dfdxe(i) = 4*pi*cos(4*pi*x(i));
end
    dfdx(1)=(f(2)-f(1))/(dx);
for i = 2:N
    dfdx(i)=(f(i+1) - f(i-1))/(2*dx);
end
dfdx(N+1)=dfdx(N);

plot(x,dfdx,'--r');
hold on;
plot(x,dfdxe,'-k');

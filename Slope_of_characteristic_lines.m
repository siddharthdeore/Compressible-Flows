% Program to calculate and plot slope and speed of sound transition with
% respect to time
% Function poly2string.m is required in order to print vector in polynomial
% form

clc;
clear all;
close all;
u=input('Enter co-eficient of polynomial = ');
%u=[0.5 0 0]
a=polyder(u);
NX=100;
x=-5:10/NX:5;
slope_a(NX+1)=0;
slope_u(NX+1)=0;
y(NX+1)=0;
for i=1:NX+1;
    if x(i)<-1
        y(i)=-1;
    end
    if x(i)>=-1 && x(i)<=1
        y(i)=1;
    end
    if x(i)>1
        y(i)=-1;
    end
 %   if(mod(i,NX/20)==0)
        for j=1:length(a)
            slope_a(i)=slope_a(i) + a(j)*y(i) ^ (length(a)-j);
        end
        for j=1:length(u)
            slope_u(i)=slope_u(i)+u(j)*y(i)^(length(u)-j);
        end
 %   end
end
figure('Name','slope of u');
plot(x,0);
xlabel('x');
ylabel('time');
grid on;
grid minor
for i=1:NX+1
%    if(mod(i,NX/20)==0)
        u_theta=atan(slope_u(i));
        if u_theta<0
            line([x(i) x(i)-2*cos(u_theta+pi/2)],[0 2*sin(u_theta+pi/2)],'Color','g');
        elseif u_theta==0
            line([x(i) x(i)-2*cos(u_theta+pi/2)],[0 2*sin(u_theta+pi/2)],'Color','k');
        else
            line([x(i) x(i)-2*cos(u_theta+pi/2)],[0 2*sin(u_theta+pi/2)],'Color','b');
        end
%    end
end

figure('Name','slope of shock -> a');
xlabel('x');
ylabel('time');
cla
grid on;
grid minor
for i=1:NX+1
%    if(mod(i,NX/20)==0)
        a_theta=atan(slope_a(i));
        if a_theta<0
            line([x(i) x(i)-2*cos(a_theta+pi/2)],[0 2*sin(a_theta+pi/2)],'Color','g');
        elseif a_theta == 0
            line([x(i) x(i)-2*cos(a_theta+pi/2)],[0 2*sin(a_theta+pi/2)],'Color','k');
        else
            line([x(i) x(i)-2*cos(a_theta+pi/2)],[0 2*sin(a_theta+pi/2)],'Color','b');
        end
%    end
end
fprintf('Given Polynomial = ');
fprintf(poly2string(u));
fprintf('\nSpeed of sound = ');
fprintf(poly2string(a));
fprintf('\n');

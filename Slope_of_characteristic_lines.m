% Program to calculate and plot slope and speed of sound transition with  respect to time
% Function poly2string.m is required in order to print vector in polynomial form
% SIDDHARTH NIMBAJIRAO DOERE [SAPIENZA UNIVERSITY OF ROME]
% SPACE AND ASTRONAUTICAL ENGINEERING, DEPARTMENT OF INDUSTRIAL AND CIVIL ENGIEERING
% deore.1823670@studanti.uniroma1.it

clc;
clear all;
close all;
u=input('Enter co-eficient of polynomial = ');
%u=[0.5 0 0]
a=polyder(u);
NX=20;
x=-5:10/NX:5;
slope_a(NX+1)=0;
slope_u(NX+1)=0;
slope_disc(NX+1)=0;
y(NX+1)=0;
for i=1:NX+1;
    if x(i)<-1
        y(i)=-1;
    end
    if x(i)>=-1 && x(i)<=1
        y(i)=0;
    end
    if x(i)>1
        y(i)=1;
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
        line([x(i) x(i)-10*cos(u_theta+pi/2)],[0 10*sin(u_theta+pi/2)],'Color','m');
    elseif u_theta==0
        line([x(i) x(i)-10*cos(u_theta+pi/2)],[0 10*sin(u_theta+pi/2)],'Color','k');
    else
        line([x(i) x(i)-10*cos(u_theta+pi/2)],[0 10*sin(u_theta+pi/2)],'Color','b');
    end
    %    end
end

figure('Name','slope of shock -> a');
xlabel('x');
ylabel('time');
grid on;
grid minor
hold on
for i=1:NX+1
    %    if(mod(i,NX/20)==0)
    a_theta=atan(slope_a(i));
    if((i<NX+1) && slope_a(i+1)==slope_a(i))
        if a_theta<0
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','m');
        elseif a_theta == 0
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','k');
        else
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','b');
        end
    end
    %    end
end
% Search for shock and expantion fans
for i=1:NX
    slope_disc(i)=slope_a(i+1)-slope_a(i);
    if(slope_disc(i)>0) % plots fan
        for j=slope_a(i):0.1:slope_a(i+1)
            a_theta=atan(j);
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','c');
        end
    end
    if(slope_disc(i)<0) % plots Shock wave
        a_theta=atan((slope_u(i+1)-slope_u(i))/(y(i+1)-y(i)));
        line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','r','LineWidth',2);
    end
end
fprintf('Given Polynomial = ');
fprintf(poly2string(u));
fprintf('\nSpeed of sound = ');
fprintf(poly2string(a));
fprintf('\n');

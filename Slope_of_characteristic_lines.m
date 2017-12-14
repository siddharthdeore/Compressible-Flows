% Program to calculate and plot slope and speed of sound transition with  respect to time
% Function poly2string.m is required in order to print vector in polynomial form
% SIDDHARTH NIMBAJIRAO DOERE [SAPIENZA UNIVERSITY OF ROME]
% SPACE AND ASTRONAUTICAL ENGINEERING, DEPARTMENT OF INDUSTRIAL AND CIVIL ENGIEERING
% deore.1823670@studanti.uniroma1.it

clc; clear all; close all;

u=input('Enter co-eficient of polynomial = ');
range=input('Enter range co-eficient of initial coundition (e. g. [-4 0 2]) = ');
value=input('Enter value  co-eficient for range of initial coundition = ');
range=[range, range(length(range))];
%u=[0.5 0 0]
a=polyder(u);
NX=140;
x=-5:10/NX:5;
slope_a(NX+1)=0;
f_u(NX+1)=0;
slope_disc(NX+1)=0;
y(NX+1)=0;
k=1;
for i=1:NX+1;
    y(i)=value(k)*sin(x(i));
    if(x(i)==range(k) && k<=(length(range)))
        k=k+1;
    end    
    for j=1:length(a)
        slope_a(i)=slope_a(i) + a(j)*y(i) ^ (length(a)-j);
    end
    for j=1:length(u)
        f_u(i)=f_u(i)+u(j)*y(i)^(length(u)-j);
    end
end

figure('Name','Initial Condition');
plot(x,y);
xlabel('x');
ylabel('U_{0}');
axis([-5 5 -5 5]);
axis square


figure('Name','slope of shock -> a');
xlabel('x');
ylabel('time');
axis([-5 5 0 1]);
axis square
% Search for shock and expantion fans
k=0;
for i=1:NX
    slope_disc(i)=slope_a(i+1)-slope_a(i);
    if(slope_disc(i)>0) % plots fan
        for j=slope_a(i):0.3:slope_a(i+1)
            a_theta=atan(j);
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color',[0.8 0.8 0.8]);
        end
    end
    if(slope_disc(i)<0) % plots Shock wave
        k=k+1;
        a_theta=atan((f_u(i+1)-f_u(i))/(y(i+1)-y(i)));
        sx1(k)=x(i);
        sx2(k)=x(i)-10*cos(a_theta+pi/2);
        sy1(k)=0;
        sy2(k)=10*sin(a_theta+pi/2);
        slp(k)=a_theta;
        line([sx1(k) sx2(k)],[sy1(k) sy2(k)],'Color','g','LineWidth',2);
    end
end

    for i=1:NX+1
    %    if(mod(i,NX/20)==0)
    a_theta=atan(slope_a(i));
    if((i<NX+1) && slope_a(i+1)==slope_a(i))
        if a_theta<0
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','b');
        elseif a_theta == 0
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color',[0.5 0.5 0.5]');
        else
            line([x(i) x(i)-10*cos(a_theta+pi/2)],[0 10*sin(a_theta+pi/2)],'Color','r');
        end
    end
    %    end
end

fprintf('Given Polynomial = ');
fprintf(poly2string(u));
fprintf('\nSpeed of sound = ');
fprintf(poly2string(a));
fprintf('\n');

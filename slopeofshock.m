clc;
clear all;
close all;
u=input('Enter co-eficient of polynomial = ');
%u=[0.5 0 0]
a=polyder(u);
NX=100;
x=-5:10/NX:5;
slopa(NX+1)=0;
slopu(NX+1)=0;
y(NX+1)=0;
for i=1:NX+1;
    if x(i)<-2
        y(i)=1;
    end
    if x(i)>=-2 && x(i)<1
        y(i)=0;
    end
    if x(i)>1
        y(i)=-1;
    end
    if(mod(i,NX/20)==0)
        for j=1:length(a)
            slopa(i)=slopa(i)+a(j)*y(i)^(length(u)-j);
        end
        for j=1:length(u)
            slopu(i)=slopu(i)+u(j)*y(i)^(length(u)-j);
        end
    end
end
u=y;
figure('Name','slope of u');
plot(x,0);
grid on;
for i=1:NX+1
    if(mod(i,NX/20)==0)
        utheta=atan(slopu(i));
        if utheta<0
            line([x(i) x(i)-2*cos(utheta+pi/2)],[0 2*sin(utheta+pi/2)],'Color','g');
        elseif utheta==0
            line([x(i) x(i)-2*cos(utheta+pi/2)],[0 2*sin(utheta+pi/2)],'Color','k');
        else
            line([x(i) x(i)-2*cos(utheta+pi/2)],[0 2*sin(utheta+pi/2)],'Color','b');
        end
    end
end

figure('Name','slope of a');
grid on;
for i=1:NX+1
    if(mod(i,NX/20)==0)
        atheta=atan(slopa(i));
        if atheta<0
            line([x(i) x(i)-2*cos(atheta+pi/2)],[0 2*sin(atheta+pi/2)],'Color','g');
        elseif atheta == 0
            line([x(i) x(i)-2*cos(atheta+pi/2)],[0 2*sin(atheta+pi/2)],'Color','k');
        else
            line([x(i) x(i)-2*cos(atheta+pi/2)],[0 2*sin(atheta+pi/2)],'Color','b');
        end
    end
end
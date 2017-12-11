function supersonic_profile(delta,alfa)

    %plot profile.
    x=-0.5:0.1:1.5;
    y=x.*0;
    plot(x,y);
    delta=delta*pi/180;
    alfa=alfa*pi/180;
    x1=0;
    y1=0;
    x2=(0.5/(cos(delta)))*cos(delta-alfa);
    y2=(0.5/(cos(delta)))*sin(delta-alfa);
    x3=1*cos(-alfa);
    y3=1*sin(-alfa);
    x4=(0.5/(cos(delta)))*cos(delta+alfa);
    y4=-(0.5/(cos(delta)))*sin(delta+alfa);
    x5=(0.5/(cos(delta)))*cos(-delta-alfa);
    y5=(0.5/(cos(delta)))*sin(-delta-alfa);
    %line([x1 x3],[y1 y3], 'color','r')
    line([x1 x2],[y1 y2],'color','r')
    line([x2 x3],[y2 y3],'color','r')
    line([0 x3], [0 y3],'color','g')
    line([x1 x5],[y1 y5],'color','r')
    line([x5 x3],[y5 y3],'color','r')
    line([0 0],[0 1],'color','r')

    %line([0 0.5*cos(delta+alfa)],[0 -0.5*sin(delta+alfa)])
    %line([0.5*cos(delta-alfa) 1],[-0.5*sin(delta-alfa) 0])
    xlim([-0.5 1.5])
    ylim([-1 1])
    grid on;
    axis square;
end
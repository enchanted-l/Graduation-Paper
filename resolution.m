global d
dd=0.5;
d=0:dd:(8-1)*dd;
for i=1:10
disp(q(0.01*i));
end

%绘图数据
x=[0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 0.09 0.1];
y=[3.5188e-07 5.6412e-06 2.8653e-05 9.0978e-05 2.2343e-04 4.6664e-04 8.7180e-04 0.0015 0.0024 0.0038;
   1.9146e-07 3.0712e-06 1.5614e-05 4.9642e-05 1.2213e-04 2.5562e-04 4.7884e-04 8.2740e-04 0.0013 0.0021;
   5.0117e-07 8.0550e-06 4.1087e-05 1.3124e-04 3.2479e-04 6.8479e-04 0.0013 0.0023 0.0037 0.0058;
   1.3181e-07 2.1116e-06 1.0713e-05 3.3963e-05 8.3241e-05 1.7343e-04 3.2311e-04 5.5479e-04 8.9518e-04 0.0014;];
figure
plot(x(1:10),y(1,1:10),'r-',x(1:10),y(2,1:10),'k-',x(1:10),y(3,1:10),'b-',x(1:10),y(4,1:10),'m--')
xlabel('x/rad','FontName','Times New Roman','FontSize',12);
ylabel('y','FontName','Times New Roman','FontSize',12);
title("MUSIC Algorithm Resolution",'FontName','Times New Roman','FontSize',12);
legend("uniform linear array","random linear array 1","random linear array 2","random linear array 3")
legend('FontName','Times New Roman','FontSize',10)
set(gcf,'color','w')
set(gcf,'Position',[220.2,437,475.2,274.4])
box off
grid on


function y=f(k)  %导向向量之和
M = 8;  %阵元数
y=0;
global d
for n=1:M
    y=y+exp(-1i*2*pi*d(n)*sin(k))/M;
end
end

function y=q(k)  %信号谱的分辨能力
y=1-(2*abs(f(k/2)).^2)*(1-abs(f(k)).'*cos(angle(f(k))-2*angle(f(k/2))))/(1-abs(f(k)).^2);
end

close all;
clear;
clc;
x=[5 10 15 20 25 30];
y=[0 0 0  10 0.3631 0.123;
   0.1644 0.0439 0.0133 0.004 0.0013 0.000383;
   3.6417e-4 1.2933e-4 4.62e-5 1.0833e-5 5.167e-6 0;];
figure
plot(x(1:6),y(1,1:6),'--r',x(1:6),y(2,1:6),'-k',x(1:6),y(3,1:6),':b')
semilogy(x,y)
xlabel('x/db','FontName','Times New Roman','FontSize',12);
ylabel('y/circ','FontName','Times New Roman','FontSize',12);
title("the Parameters of MUSIC",'FontName','Times New Roman','FontSize',12);
legend("N=4","N=8","N=16")
legend('FontName','Times New Roman','FontSize',10)
set(gcf,'color','w')
set(gcf,'Position',[220.2,437,475.2,274.4])
box off
grid on
%0420
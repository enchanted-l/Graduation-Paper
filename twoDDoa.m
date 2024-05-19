clear
close all;
clc
 
Nx  = 8;
Ny  = 8;
c   =  physconst('Lightspeed');
lambda = c/77e9;    %% 波长
deta   =  lambda/2;    %% 天线间隔
dx = 0:deta:(Nx-1)*deta;
dy = 0:deta:(Ny-1)*deta;
snapshot = 512;     %% 信号采样长度
 
source = [  15,60;
            40,17;
            34,27]; %% 波达方向(方位向，俯仰向)
 
source_num = size(source,1);
Ax = zeros(Nx,source_num);
Ay = zeros(Ny,source_num);
for i = 1:source_num
    Ax(:,i) = exp(1j*2*pi/lambda*dx(:)*cosd(source(i,1))*sind(source(i,2)));
    Ay(:,i) = exp(1j*2*pi/lambda*dy(:)*sind(source(i,1))*sind(source(i,2)));
end
 
S = randn(source_num,snapshot);  %产生随机信号
A = [Ax.' Ay.'].';               %合并x、y轴方向上的导向矢量
Z = A*S;                         %L型阵列接收的数据
 %X = Ax*S;                      %%x轴方向阵列接收的数据
 %Y = Ay*S;                      %%y轴方向阵列接收的数据
 %Z = [X;Y];
 
 
%%  加入噪声
SNR = 40; %单位dB
Z = Z +(randn(size(Z)).*std(Z))/db2mag(SNR);
 
R = (1/snapshot)*Z*conj(Z.');
[V,D] = eig(R);             %在matalb2021版本以上，特征值已经从小到大排列
Un = V(:,1:end-source_num);          %提取小特征对应的特征向量作为噪声子空间 M*(M-K)
 
Azimuth = 0:0.1:60;
Pitch   = 0:0.1:90;
P2D = zeros(length(Azimuth),length(Pitch));
for n = 1:length(Azimuth)
    for m = 1:length(Pitch)
        ax = exp(1j*2*pi/lambda*dx(:)*cosd(Azimuth(n))*sind(Pitch(m)));
        ay = exp(1j*2*pi/lambda*dy(:)*sind(Azimuth(n))*sind(Pitch(m)));
        a  = [ax.' ay.'].';
        P2D(n,m) = 1/(a'*(Un*Un')*a);
    end
end
Pazimuth = sum(abs(P2D),2); 
Ppitch   = sum(abs(P2D),1);
 
%%  方位-俯仰向2D图
figure;
mesh(Pitch,Azimuth,db(P2D));
xlabel('Pitch(°)');
ylabel('Azimuth(°)');
title('方位-俯仰向图');
 
%%  绘制方位向剖面
figure;
plot(Azimuth,db(Pazimuth),'LineWidth',1.5);
title('目标方位角剖面');
xlabel('Azimuth(°)');
ylabel('幅度(dB)');
 
%%  绘制俯仰向剖面
figure;
plot(Pitch,db(Ppitch),'LineWidth',1.5);
title('目标俯仰角剖面');
xlabel('Azimuth(°)');
ylabel('幅度(dB)');
clear all
close all
times=10;
data=zeros(1,times);
for i = 1:times
derad=pi/180;                           % 角度->弧度
radeg=180/pi;                           % 弧度->角度
twpi=2*pi;
kelm=8;                                 % 阵元数
dd=0.5;                                 % 阵元间距
d=0:dd:(kelm-1)*dd;
iwave=3;                                % 信源数
theta=[10 20 30];                       % 波达方向
snr=10;                                 % 信噪比
n=512;                                  % 采样数
A=exp(-1i*twpi*d.'*sin(theta*derad));   % 方向向量
S=randn(iwave,n);                       % 信源信号
X0=A*S;                                 % 接收信号
X=awgn(X0,snr,'measured');              % 添加噪声
Rxx=X*X';                               % 计算协方差矩阵
InvS=inv(Rxx);
[EVx,Dx]=eig(Rxx);                      % 特征值分解
EVAx=diag(Dx)';
[EVAx,Ix]=sort(EVAx);                   % 特征值从小到大排序
EVAx=fliplr(EVAx);                      % 左右翻转，从大到小排序
EVx=fliplr(EVx(:,Ix));
  
% root-MUSIC
Unx=EVx(:,iwave+1:kelm);                % 噪声子空间
syms z;
pz=z.^([0:kelm-1]');
pz1=(z^(-1)).^([0:kelm-1]);
fz=z.^(kelm-1)*pz1*Unx*Unx'*pz;         % 构造多项式
a=sym2poly(fz);                         % 符号多项式->数值多项式
zx=roots(a);                            % 求根
rx=zx';
[as,ad]=(sort(abs((abs(rx)-1))));
DOAest=asin(sort(angle(rx(ad([1,3,5])))/pi))*180/pi;
disp(DOAest);
ytest=[10,20,30];
testerror=ytest-DOAest;
test_mse=mse(testerror); 
data(:,i)=test_mse;
end

data=data(:);
mse=mean(data);
display(mse)
M=3; %待估计信源数
N=8; %无人机集群阵元数
K=4; %基站数
snr=50;
Er = [10; 20; 30];
H=randn(K,M);
S=H*Er;
S1=awgn(S,snr,'measured'); %将白色高斯噪声添加到信号中;
E=inv(H'*H)*H'*S1;
display(E)
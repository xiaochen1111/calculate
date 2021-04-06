% =========================================================================
% =                                                                       =
% =                   Demo of anomaly detection                           =
% =                             by                                        =
% =                          Chuanfeng Li                                 =
% =                       date: 02.03.2020                                =
% =                                                                       =
% =                               HIT                                     =
% =                   e-mail: licf1996@gmail.com                          =
% main
%% Import data
clc
clear all
x=importdata('C:\Users\29721\Desktop\电力电子变换器资料\li_chuanfeng_test\calculate\data1.xls');
% x=xlsread('C:\Users\29721\Desktop\电力电子变换器资料\li_chuanfeng_test\calculate\data');
x=x.Sheet1;
% ;
%% Preprocess
clc
x1=x(2:end,:);  % 剔除第一行 m*k m个样本，k个批次
[m,k]=size(x1);
N=m*k;
x2=reshape(x1,[1,N]);
x2(isnan(x2))=0;
zzzz=find(x2==0);
x=x2;
x(zzzz)=[];
%% main
clc
ii_F=[];
x_star=cv_calcute(x); %不需要是矩阵
NN=length(x);
for i=1:1:NN-1
    x_i=x(i);
    [MNR,C]=MNR_calculate(x_i,x,x_star); %不需要矩阵 输入数据必须大于18个小于36个
    if (MNR<=C)
        Flag=0;
    else
        Flag=1;
        ii_F=[ii_F,i];
    end
end
x(ii_F)=[];
if length(x)<18
    disp('该数据源数量不够18，不能计算')
end

ADK=ADK_calculate(x,k,x1); % 需要矩阵
ADC=ADC_calculate(x,k,x1); % 需要矩阵
OSL_normal=normal_osl(x); % 不需要矩阵
[alpha,beta,OSL_weibull]=weibull_osl(x); % 不需要矩阵

% B计算
if(OSL_normal<=0.05||OSL_weibull>=0.05||OSL_weibull>=10*OSL_normal)
    vB=3.803+exp(1.79-0.516*log(NN)+5.1/(NN-1));
B_weibull=alpha*(0.10536)^(1/beta)*exp(-vB./(beta*sqrt(NN)));
else
kB=1.282+exp(0.958-0.520*log(NN)+3.19/NN);
B_nomal=mean(x)-kB;
end


function OSL=normal_osl(XXX)
% Normal OSL 
A=unique(XXX);
% =================(23)================================
z=(A-mean(A))./std(A);
% z=(log(A)-mean(A))./std(A);
n=length(A);
AD=0;
[mu,sigma]=normfit(z);
% =================(12)================================
for i=1:1:n
% =================(4)==============================
z_i=(A(i)-mean(A))./std(A);
z_n_1_i=(A(n+1-i)-mean(A))./std(A);
% =================(5)================================
% F_z_i=normcdf(A(i),mu,sigma);
% F_z_n_1_i=normcdf(A(n+1-i),mu,sigma);
F_z_i=normcdf(z_i,mu,sigma);
F_z_n_1_i=normcdf(z_n_1_i,mu,sigma);
ad=(1-2.*i).*(log(F_z_i)+log(1-F_z_n_1_i))./n;
AD=AD+ad;
end
AD=AD-n;
% =================(14)================================
AD_star=(1+4./n-25./(n.^2))*AD;
% =================(13)================================
KK=-0.48+0.78*log(AD_star)+4.58*AD_star;
OSL=1/(1+exp(KK));
%% test 利用matlab 内置函数判断
% [H1,s1]=adtest(A,'Distribution','weibull','Alpha',0.05);
% [H2,s2]=adtest(A,'Distribution','norm','Alpha',0.05);
end
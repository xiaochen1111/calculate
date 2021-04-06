function [alpha,beta,OSL_weibull]=weibull_osl(XXX)
% Weibull
A=unique(XXX);
[ahat]=mle(A,'distribution','wbl');
alpha=ahat(1);
beta=ahat(2);
n=length(A);
AD=0;
for i=1:1:n
% =================(4)==============================
z_i=(A(i)./alpha).^beta;
z_n_1_i=(A(n+1-i)./alpha).^beta;
% =================(5)================================
ad=(1-2.*i)./n.*(log(1-exp(-z_i))-z_n_1_i);
AD=AD+ad;
end
AD=AD-n;
% =================(7)================================
AD_star=(1+0.2./(sqrt(n))).*AD;
% =================(6)================================
KK=-0.10+1.24*log(AD_star)+4.48*AD_star;
OSL_weibull=1./((1+exp(KK)));
end
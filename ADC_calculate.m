% ADC calculate
function ADC=ADC_calculate(x,k,x1)
[m,k]=size(x1);
R=0;
for i=1:1:k
    % 为了消除NAN 对length影响,进行如下操作
    zz1=find(isnan(x1(:,i)));
    zz2=length(zz1);
    R=R+1./(length(x1(:,i))-zz2);
end
n=length(x);
i=1:1:n;
T=0;
for ii=1:1:n-1
    t=1./ii;
    T=T+t;
end
G1=0;
for ki=1:1:n-2
    for jj= ki+1:1:n-1
        g=1./((n-i(ki))*jj);
        G1=G1+g;
    end
    G=G1;
end

a=(4*G-6)*(k-1)+(10-6*G)*R;
b=(2*G-4)*k.^2+8*T*k+(2*G-14*T-4)*R-8*T+4*G-6;
c=(6*T+2*G-2)*k.^2+(4*T-4*G+6)*k+(2*T-6)*R+4*T;
d=(2*T+6)*k^2-4*T*k;
sigma2=(a*n^3+b*n^2+c*n+d)./(n-1)./(n-2)./(n-3)./(k-1)^2;  
b0=1.96;
b1=1.149;
b2=-0.391;
ADC=1+sqrt(sigma2)*(b0+b1./(sqrt(k-1))+b2./(k-1));
end
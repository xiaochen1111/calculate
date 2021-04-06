% ADK calculate
function ADK=ADK_calculate(x,k,x1)
n=length(x);
Z=unique(x); % 递增排序，剔除重复
L=length(Z);
AD2=0;
for ii=1:1:k
    AD1=0;
    for jj= 1:1:L
    h=length(find(Z(jj)==Z(:)));
    H=length(find(Z(:)==Z(jj)))./2+length(find(Z(:)<Z(jj)));
    F=length(find(x1(:,ii)==Z(jj)))./2+length(find(x1(:,ii)<Z(jj)));
      % 为了消除NAN 对length影响,进行如下操作
    zz1=find(isnan(x1(:,ii)));
    zz2=length(zz1);
    n_i=length(x1(:,ii))-zz2;
    ad1=h*(n*F-n_i*H)^2./(H*(n-H)-n*h/4)./n_i;
    AD1=AD1+ad1;
    end
%     zz1=find(isnan(x1(:,ii)));
%     zz2=length(zz1);
%     n_i=length(x1(:,ii))-zz2;
%     AD1=AD1./n_i;
    AD2=AD2+AD1;
end
ADK=AD2*(n-1)./(k-1)./(n^2);
end
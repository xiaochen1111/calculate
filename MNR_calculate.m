% MNR calculate
function [MNR,C]=MNR_calculate(x_i,x,x_star)
n=length(x);
r=(x_i-mean(x))./std(x_star);
[MNR]=max(abs(r));
CCC=[2.652, 2.681, 2.708, 2.734, 2.758, 2.78, 2.802, 2.822, 2.841, ...
    2.859, 2.876, 2.893, 2.908, 2.924, 2.938]; % ‘§…Ë÷µ
C=CCC(n+1-18);
end
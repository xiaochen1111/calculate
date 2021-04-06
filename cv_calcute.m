% CV calculate
function x_star=cv_calcute(x)
CV=std(x)./mean(x);
if (CV<0.04)
    CV_star=0.06;
elseif (CV<0.08)
    CV_star=(0.5*CV)+0.04;
else
    CV_star=CV;
end
x_star=x+(x-mean(x))*((CV_star./CV)-1);
end
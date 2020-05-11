function x=normP(x)

x=x-mean(x);
x=x/sqrt(mean(x.^2));
x(~isfinite(x))=0;
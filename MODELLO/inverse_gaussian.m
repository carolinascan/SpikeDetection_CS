function [f] = inverse_gaussian(x,mu,lambda)
f=(sqrt(lambda./(2*pi.*x.^3))).*exp(-((lambda.*((x-mu).^2))./(2.*(mu.^2).*x)));
end


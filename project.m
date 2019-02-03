function [ x ] = project( X,R,T,K )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
np = size(X,2);
x = K*(R*X + T*ones(1,np));
x(1,:)  = x(1,:)./x(3,:);
x(2,:)  = x(2,:)./x(3,:);
x(3,:)  = x(3,:)./x(3,:);

end


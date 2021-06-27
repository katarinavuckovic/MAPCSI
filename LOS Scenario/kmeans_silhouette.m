function [k,smean] = kmeans_silhouette(X,kmax)
%UNTITLED5 Summary of this function goes here
%   This function finds the optimal k using silhouette method
%Input:
%  X - data in Nx2 formal [xi,yi];
%  kmax = largest k value to consider
%Output:
% k - optimal k
% smean - is the S-score for each k value
size = length(X);
KMAX = min(size, kmax);
for i = 2:KMAX
    clust = kmeans(X,i,'distance','sqeuclidean','emptyaction','drop');
    s = silhouette(X,clust,'Euclidean');
    smean(i) = mean(s);
end
[smax k] = max(smean);
end

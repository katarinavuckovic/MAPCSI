
% MAP-CSI Implamentation for LOS Scenario
% Author: Katarina Vuckovic, kvuckovic@knights.ucf.edu
% Date: June 26, 2021
%-------------------------------------------------------------------------%
clear all
close all
clc
%Load data and initialize variables
%--------------------------------------------------------------------------%
load('LOS_CSI60x60.mat')
Nt = 60; %Same as Nt in the dataset
Nc = 60; %Same as Nc in dataset
Ntt = 180; %
Ncc = 180;
sample = 19; % pick a sample from dataset
P =5 ; % Pick the number of rays to use for localization.
m =180/Ntt;
T =60;
kmax= 3 % select maximum number of clusters for classification
crossweight = [];
color = ['b.';'y.';'r.';'c.';'m.';'w.';'k.';'b*';'r*'];

%Convert CSI to ADP and extract top P angles, delays, powers
%--------------------------------------------------------------------------%
CSI =  reshape(H(sample,:,:),[Nt Nc]);
ADP = abs(CSI2ADP_theta_NN(CSI,Ntt,Ncc, Nt, Nc)); % Eq(5)
[angles,delays,powers] = ADPPeaksUnique1(ADP,P)

angles = m*angles;
delays =2*(Nc/Ncc)* delays;

%Load Birdview image of enviroment (2D Map)
%-------------------------------------------------------------------------%
img = imread('BW1.jpg');
figure(1);
imshow(img)
hold on


%Part 1: finding all point and weight (Algorithm 1)
%-------------------------------------------------------------------------%
%Filtering - rays at the 'noReflection' angles do not reflect because there
%is no scatterer located at these point to reflect the ray.
%-------------------------------------------------------------------------%
noReflection = [8 9 10 170 171 0 180];
for i =1:length(noReflection)
    index = find(angles==noReflection(i));
    angles(index) = [];
    delays(index) = [];
    powers(index) = [];
end
% Find  points from rays based on angle and delay of possible user
% locations.
%-------------------------------------------------------------------------%
for i = 1:length(angles)
    
    alpha = angles(i);
    delay = delays(i);
    distance = delay*3*(10^(-1))*4.44; % delay in ns times 3X10^8, 4.44pix in meter
    period = T*3*(10^(-1))*4.44; %need to change this when I go to `180
    
    for n =1:7 % The number of iteration will depdend on the area of the enivoroment
        d =  (distance+(n-1)*period);
        x = d*cosd(alpha);
        y = d*sind(alpha);
        xdelay = 343 - x;
        ydelay = 267 - y;
        if(alpha<=30)
            %1st reflection
            if (xdelay<73)
                delx = (73 - xdelay);
                xdelay = 73 + delx;
                %2st reflection
                if(alpha<14&&ydelay<177)
                    dely = (177 - ydelay);
                    ydelay = 177 + dely;
                end
            end
        end
        if (alpha>30&&alpha<147)
            %1st reflection
            if (ydelay<177)
                dely = (177 - ydelay);
                ydelay = 177 + dely;
                %2nd reflection
                if(ydelay>267)
                    if((alpha>44&&alpha<66)||(alpha>79&&alpha<106)||(alpha>119))
                        dely = ydelay - 267;
                        ydelay = 267 - dely;
                    end
                end
            end
        end
        if(alpha>=147)
            if (xdelay>628)
                delx = (xdelay-628);
                xdelay = 628 - delx;
            end
        end    

        %Filter points that are outside the area of interet (AOI)
        if(xdelay>=120&&xdelay<=590)
            if(ydelay>=177&&ydelay<=220)
                        crossweight = [crossweight;[xdelay,ydelay,powers(i),angles(i)]];
                plot(xdelay,ydelay,'g.',...
                    'MarkerSize',10,'LineWidth',3);
            end
        end
    end
end

%Plots rays and potential point represeting possible user locations
[img,lines,powl]=Reflection4pl(img,angles,powers,delays);

%PART 2: KMEANS ELBOW Finding clusters (Algorithm 2)
%-------------------------------------------------------------------------%
% Initialization 
newCross = [];
newCross= [crossweight(:,1),crossweight(:,2)];
IDX = [];
C = [];
SUMD = [];
k = [];
s = size(newCross);


if(s(1)==1)
    IDX = 1;
    C = newCross;
    SUMD = 1;
    k = 1;
else
    [k,smean] = kmeans_silhouette(newCross,kmax);
    [IDX,C,SUMD] = kmeans(newCross,k,'distance','sqeuclidean');
    xmean = mean(newCross(:,1));
    ymean = mean(newCross(:,2));
    d = [];
    for i=1:s(1)
        d(i) = sqrt((xmean-newCross(i,1)).^2+(ymean-newCross(i,2)).^2);
    end
    if (max(d)<10)
        IDX = ones(s(1),1);
        C = [xmean, ymean];
        SUMD = ones(s(1),1);
        k =1;
    else
        [k,smean] = kmeans_silhouette(newCross,kmax);
        [IDX,C,SUMD] = kmeans(newCross,k,'distance','sqeuclidean');
    end
    
end
crossweightindex = [crossweight,IDX];
%Plot the clusters in different colors
for i = 1:length(IDX)
    for j = 1:k
        if(IDX(i)==j)
            
            plot(newCross(i,1),newCross(i,2),color(j,:),'MarkerSize',20);
        end
    end
end

%PART 3: selecting the correct cluster based on cluster size
%-------------------------------------------------------------------------%
%Filter points such taht a ray only contributes 1 point to cluster
weight = crossweightindex(:, 3);
index_weight_angle = [IDX,weight,crossweight(:,4)];
unique_iwa = unique(index_weight_angle(:,1:3),'rows');
IDXu = unique_iwa(:,1);
weight = unique_iwa(:,2);
weight_probability = [];
% Sum points in cluster
for i = 1:length(IDXu)
    for j = 1:k
        index = find(IDXu(:)==j);
        weight_probability(j) = sum(weight(index));
    end
end
[v i] = max(weight_probability);
estimate = C(i,:);

%Plot centroids of all clusters
%-------------------------------------------------------------------------%
for i =1:length(C)
    plot(C(i,1),C(i,2),'k+',...
        'MarkerSize',15,'LineWidth',3);
end
%Plot Centroid of selected cluster (Estimated user location)
%-------------------------------------------------------------------------%
plot(estimate(1),estimate(2),'g+',...
    'MarkerSize',15,'LineWidth',3);
%Plot true actual user location
%-------------------------------------------------------------------------%
temp = strcat(num2str(L(sample,1)),'_',num2str(L(sample,2)));
[img,loc] = user_location(temp, img);
hold on
%PART 4: Computing Error 
%-------------------------------------------------------------------------%
error = sqrt((estimate(1)-loc(1)).^2+(estimate(2)-loc(2)).^2);
error_m = error*0.2



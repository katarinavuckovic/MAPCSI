clear all
close all
clc
 
%select 'color_direct' for LOS dataset or 'colo_blocked'for Mixed dataset
%Open Data_Generator to adjust number of ULA antennas (Nt) and number of
%subcarriers (Nc)
[Dataset,params]= Dataset_Generator('colo_direct'); 
f = 'D:/MATLAB/data_generation_package/data_generation_package/MAT functions/'; %location of 

% Adjust based on ULA antennas
Nt = 60;
Nc = 60;
tic
for i =1:5000
    H = Dataset{1,1}.user{1,i}.channel;
    L = Dataset{1,1}.user{1,i}.loc;
    save('Dataset.mat','H','L');
end
toc
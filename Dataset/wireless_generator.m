% ---- ViWi: A Dataset framework for Vision-Wireless Data Generation ----%
% Facilitating ML/DL research in vision-aided wireless communication (VAWC)
% and wireless-augmented vision (WAV). 
% Author: Ahmed Alkhateeb
% Date: Oct. 31, 2019 
% ---------------------------------------------------------------------- %
function [wireless_dataset,params]= wireless_generator(params)

% -------------------------- DeepMIMO Dataset Generation -----------------%
fprintf(' Wireless Dataset Generation started \n')

% Read scenario parameters
file_scenario_params=strcat('./RayTracing Scenarios/',params.scenario,'/',params.scenario,'.params.mat')
load(file_scenario_params)

params.num_BS=num_BS;

num_rows=max(min(user_grids(:,2),params.active_user_last)-max(user_grids(:,1),params.active_user_first)+1,0);
params.num_user=sum(num_rows.*user_grids(:,3));                     % total number of users
 
current_grid=min(find(max(params.active_user_first,user_grids(:,2))==user_grids(:,2)));
user_first=sum((max(min(params.active_user_first,user_grids(:,2))-user_grids(:,1)+1,0)).*user_grids(:,3))-user_grids(current_grid,3)+1;
user_last=user_first+params.num_user-1;
 
BW=params.bandwidth*1e9;                                     % Bandwidth in Hz
 
% Reading ray tracing data
fprintf(' Reading the channel parameters of the ray-tracing scenario %s', params.scenario)
count_done=0;
reverseStr=0;
percentDone = 100 * count_done / length(params.active_BS);
msg = sprintf('- Percent done: %3.1f', percentDone); %Don't forget this semicolon
fprintf([reverseStr, msg]);
reverseStr = repmat(sprintf('\b'), 1, length(msg));
    
for t=1:1:params.num_BS
    if sum(t == params.active_BS) ==1
        filename_DoD=strcat('./RayTracing Scenarios/',params.scenario,'/',params.scenario,'.',int2str(t),'.DoD.mat');
        filename_CIR=strcat('./RayTracing Scenarios/',params.scenario,'/',params.scenario,'.',int2str(t),'.CIR.mat');
        filename_Loc=strcat('./RayTracing Scenarios/',params.scenario,'/',params.scenario,'.Loc.mat');
        [TX{t}.channel_params]=read_raytracing(filename_DoD,filename_CIR,filename_Loc,params.num_paths,user_first,user_last); 
 
        count_done=count_done+1;
        percentDone = 100 * count_done / length(params.active_BS);
        msg = sprintf('- Percent done: %3.1f', percentDone); %Don't forget this semicolon
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
    end
end


% Constructing the channel matrices 
TX_count=0;
for t=1:1:params.num_BS
    if sum(t == params.active_BS) ==1
        fprintf('\n Constructing the wireless Dataset for BS %d', t)
        reverseStr=0;
        percentDone = 0;
        msg = sprintf('- Percent done: %3.1f', percentDone); 
        fprintf([reverseStr, msg]);
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
        TX_count=TX_count+1;
        for user=1:1:params.num_user         
          [wireless_dataset{TX_count}.user{user}.channel]=construct_wireless_channel(TX{t}.channel_params(user),params.num_ant_x,params.num_ant_y,params.num_ant_z, ...
              BW,params.num_OFDM,params.OFDM_sampling_factor,params.OFDM_limit,params.ant_spacing);
          wireless_dataset{TX_count}.user{user}.loc=TX{t}.channel_params(user).loc;
          %This is addded for Datamanagement2 and it gets AOA,AOD,TOA
          wireless_dataset{TX_count}.user{user}.DoD_theta=TX{t}.channel_params(user).DoD_theta;
          wireless_dataset{TX_count}.user{user}.DoD_phi=TX{t}.channel_params(user).DoD_phi;
          wireless_dataset{TX_count}.user{user}.ToA=TX{t}.channel_params(user).ToA;
          wireless_dataset{TX_count}.user{user}.power=TX{t}.channel_params(user).power;
          
          percentDone = 100* round(user / params.num_user,2);
          msg = sprintf('- Percent done: %3.1f', round(percentDone,2));
          fprintf([reverseStr, msg]);
          reverseStr = repmat(sprintf('\b'), 1, length(msg));
        end       
    end   
end

if params.saveDataset==1
    sfile_wireless=strcat('./data/wireless_dataset.mat');
    save(sfile_wireless,'wireless_dataset','-v7.3');
end

fprintf('\n Wireless Dataset Generation completed \n')
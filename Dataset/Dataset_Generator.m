% ---- ViWi: A Dataset framework for Vision-Wireless Data Generation ----%
% Facilitating ML/DL research in vision-aided wireless communication (VAWC)
% and wireless-augmented vision (WAV). 
% Author: Ahmed Alkhateeb
% Date: Oct. 31, 2019 
% ---------------------------------------------------------------------- %

function [wireless_dataset,params]=Dataset_Generator(scenario)
Nt = 60;
Nc = 60;
% ------  Inputs to the DeepMIMO dataset generation code ------------ % 

%------Ray-tracing scenario
params.scenario=scenario;          % The adopted ray tracing scenarios [check the available scenarios at www.aalkhateeb.net/DeepMIMO.html]

%------DeepMIMO parameters set
%Active base stations 
params.active_BS= [1];               % Includes the numbers of the active BSs (values from 1-18 for 'O1')

% Active users
params.active_user_first=1;         % The first row of the considered receivers section (check the scenario description for the receiver row map)
params.active_user_last=5000;       % The last row of the considered receivers section (check the scenario description for the receiver row map)

% Number of BS Antenna 
params.num_ant_x=Nt;                 % Number of the UPA antenna array on the x-axis 
params.num_ant_y=1;                 % Number of the UPA antenna array on the y-axis 
params.num_ant_z=1;                 % Number of the UPA antenna array on the z-axis
                                    % Note: The axes of the antennas match the axes of the ray-tracing scenario
                              
% Antenna spacing
params.ant_spacing=0.5;             % ratio of the wavelnegth; for h alf wavelength enter .5        

% System bandwidth
params.bandwidth=0.2;              % The bandiwdth in GHz 

% OFDM parameters
params.num_OFDM=Nc;                 % Number of OFDM subcarriers
params.OFDM_sampling_factor=1;      % The constructed channels will be calculated only at the sampled subcarriers (to reduce the size of the dataset)
params.OFDM_limit=Nc;               % Only the first params.OFDM_limit subcarriers will be considered when constructing the channels

% Number of paths
params.num_paths= 25;                % Maximum number of paths to be considered (a value between 1 and 25), e.g., choose 1 if you are only interested in the strongest path

params.saveDataset=0;               % This should be 1 if dataset to be saved automatically
 
% -------------------------- DeepMIMO Dataset Generation -----------------%

[wireless_dataset,params]= wireless_generator(params);

end

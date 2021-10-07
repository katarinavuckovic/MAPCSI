# MAP-CSI: Single-site Map-Assisted Localization Using Massive MIMO CSI

## Dataset
The dataset consists of (CSI, Location) pairs. This size of the CSI matrix of size NtxNc depends on the number of transmitters (Nt) and number of subcarriers (Nc).  
The dataset is generated from [ViWi Dataset](https://viwi-dataset.net/scenarios.html). In this project "Colocated camera with direct view" and "colocated camera with blocked view" sencarios are used for datageneration.  These two scenarios are referred to in the paper as "LOS dataset" and "Mixed dataset", respectively. 
For this part you need to dowload RayTracingScenarios from [ViWi Dataset](https://viwi-dataset.net/scenarios.html).

## LOS Scenario
You will need to the dataset generated from "Colocated camera with direct view" to the LOS Scenario folder. 
main_LOS.m is the main demo file. The output of the main_LOS is a 2D Map of the enviroment with the following thing superimposed on the map:
- P rays (where P is the number of rays selected in the simualtion)
- points on rays that reperent 'candidate" user locations
- clusters of points shown by different colors and centroid of each cluster is shown with 'black +' 
- Estimated user location is 'green +'
- Actual user location is 'magenta +'

![image](https://user-images.githubusercontent.com/71682568/124682704-75a45a80-de99-11eb-8e0c-e83ae1d757c0.png)

## Mixed Scenario
Same as LOS scenario, expect it is used for datasets generated from "colocated camera with blocked view". 
The image displays two rectangles on the map that represent the buses. 

![image](https://user-images.githubusercontent.com/71682568/124682853-c87e1200-de99-11eb-9d93-f5b693d7a6eb.png)

## Questions 
If you have any question regarding the codes, dont hesitate to contact me at kvuckovic993@gmail.com or kvuckovic@knights.ucf.edu

## Paper
[Here](https://arxiv.org/abs/2110.00654)

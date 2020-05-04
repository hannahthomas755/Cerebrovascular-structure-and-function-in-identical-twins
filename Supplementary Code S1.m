% WALNUT: Regional Cerebral Blood Flow Distribution Calculation 
% Author - Usaid Rana 2018   

%% INPUTS %%

% Change the following values to patient specific values.

%%% INLET FLOWS [kg/s] %%% 
RVA = 0.00136134; % Right vertebral artery
LVA = 0.001547961; % Left vertebral artery
RICA = 0.005296495; % Right internal carotid artery
LICA = 0.003980895; % Left internal carotid artery

%%% ANATOMICAL VARIATION %%% 
% If LPCoA exists, x =1. If absent x = 0. 
% If RPCoA exists, y =1. If absent y = 0.   
x = 1; y = 1;   

%% CALCULATION %%

% Inlet Flows   
TCBF = RVA + LVA + RICA + LICA; 
PI = (LVA + RVA)/TCBF; 
AI = (LICA + RICA)/TCBF;   

% Outlet Flows (% of TCBF)   
Zone1_CF = (15/28)*PI; 
Zone2_RP = ((6.5 + y*1.5)/28)*PI; 
Zone3_RMF = ((22.5 - y*1.5)/72)*AI; 
Zone4_AF = (23/72)*AI; 
Zone5_LMF = ((22.5 - x*1.5)/72)*AI; 
Zone6_LP = ((6.5 + x*1.5)/28)*PI; 
Zone7_RF = (4/72)*AI;   

% Expected Flows (kg/s)   
Zone1_Exp = Zone1_CF*TCBF; 
Zone2_Exp = Zone2_RP*TCBF; 
Zone3_Exp = Zone3_RMF*TCBF;  
Zone4_Exp = Zone4_AF*TCBF; 
Zone5_Exp = Zone5_LMF*TCBF; 
Zone6_Exp = Zone6_LP*TCBF; 
Zone7_Exp = Zone7_RF*TCBF;   

Zone1_Print = 'Zone 1 Expected Flow Rate [kg/s]: %.8e\n';
Zone2_Print = 'Zone 2 Expected Flow Rate [kg/s]: %.8e\n'; 
Zone3_Print = 'Zone 3 Expected Flow Rate [kg/s]: %.8e\n'; 
Zone4_Print = 'Zone 4 Expected Flow Rate [kg/s]: %.8e\n';
Zone5_Print = 'Zone 5 Expected Flow Rate [kg/s]: %.8e\n';
Zone6_Print = 'Zone 6 Expected Flow Rate [kg/s]: %.8e\n';
Zone7_Print = 'Zone 7 Expected Flow Rate [kg/s]: %.8e\n';   

fprintf(Zone1_Print, Zone1_Exp); 
fprintf(Zone2_Print, Zone2_Exp);
fprintf(Zone3_Print, Zone3_Exp); 
fprintf(Zone4_Print, Zone4_Exp);
fprintf(Zone5_Print, Zone5_Exp); 
fprintf(Zone6_Print, Zone6_Exp);
fprintf(Zone7_Print, Zone7_Exp);   

Dist1_Print = 'Zone 1 perc of TCBF: %.4f\n'; 
Dist2_Print = 'Zone 2 perc of TCBF: %.4f\n'; 
Dist3_Print = 'Zone 3 perc of TCBF: %.4f\n'; 
Dist4_Print = 'Zone 4 perc of TCBF: %.4f\n';
Dist5_Print = 'Zone 5 perc of TCBF: %.4f\n'; 
Dist6_Print = 'Zone 6 perc of TCBF: %.4f\n'; 
Dist7_Print = 'Zone 7 perc of TCBF: %.4f\n';     

fprintf(Dist1_Print, Zone1_CF*100); 
fprintf(Dist2_Print, Zone2_RP*100); 
fprintf(Dist3_Print, Zone3_RMF*100); 
fprintf(Dist4_Print, Zone4_AF*100); 
fprintf(Dist5_Print, Zone5_LMF*100); 
fprintf(Dist6_Print, Zone6_LP*100); 
fprintf(Dist7_Print, Zone7_RF*100);   

ExpectedFlows = [Zone1_Exp; Zone2_Exp; Zone3_Exp; Zone4_Exp; Zone5_Exp; Zone6_Exp; Zone7_Exp]; 
ExpectedPercs = [Zone1_CF*100; Zone2_RP*100; Zone3_RMF*100;Zone4_AF*100;Zone5_LMF*100; Zone6_LP*100; Zone7_RF*100];   

%% OUTPUTS %%

CSVMatrix = [ExpectedFlows, ExpectedPercs]; 
csvwrite('expectedflow.csv',CSVMatrix) 
type expectedflow.csv 

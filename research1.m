% First, I imported the Data_IER.csv file
% Make sure to have it in the same folder !

%% PLEASE RUN THE CODE TWICE IN ORDER TO HAVE ALL THE VALUES CORRECTLY !!

%% 
ds = table2dataset(DataIER);
gender = categorical(DataIER.gender);

%computing number of participants
lel = countcats(gender);
T = table(categories(gender),lel)

%% Changing all the NaN into '0'
DataIER.dag_zwa1(isnan(DataIER.dag_zwa1))=0;
DataIER.tijd_zwa1_uur(isnan(DataIER.tijd_zwa1_uur))=0;
DataIER.tijd_zwa1_min(isnan(DataIER.tijd_zwa1_min))=0;

DataIER.dag_mat1(isnan(DataIER.dag_mat1))=0;
DataIER.tijd_mat1_uur(isnan(DataIER.tijd_mat1_uur))=0;
DataIER.tijd_mat1_min(isnan(DataIER.tijd_mat1_min))=0;

DataIER.dag_wan1(isnan(DataIER.dag_wan1))=0;
DataIER.tijd_wan1_uur(isnan(DataIER.tijd_wan1_uur))=0;
DataIER.tijd_wan1_min(isnan(DataIER.tijd_wan1_min))=0;


%% Grouping people by years and genders

%Groups with respect to year
gr2019 = ds(ds.year == 2019, :);
gr2020 = ds(ds.year == 2020, :);

%2019 participants divided by gender
grFem2019 = gr2019(gr2019.gender == 'Female', :);
grMale2019 = gr2019(gr2019.gender == 'Male', :);

%2020 participants divided by gender
grFem2020 = gr2020(gr2020.gender == 'Female', :);
grMale2020 = gr2020(gr2020.gender == 'Male', :);

%% Perceived physical - Attitude
% 1. I think that I get enought exercise - scale 0-7
% 2. How do you estimate your level of physical activities - scale 0-7
% erv.fa column is the mean value of questions 1 and 2

%computing mean value of the group
meanAttF2019 = mean(grFem2019.erv_fa);
meanAttM2019 = mean(grMale2019.erv_fa);
meanAttF2020 = mean(grFem2020.erv_fa);
meanAttM2020 = mean(grMale2020.erv_fa);
%Standard deviation
stdAttF2019 = std(grFem2019.erv_fa);
stdAttM2019 = std(grMale2019.erv_fa);
stdAttF2020 = std(grFem2020.erv_fa);
stdAttM2020 = std(grMale2020.erv_fa);

%% Plotting Attitude

% Female2019
pdFemale2019 = fitdist(grFem2019.erv_fa,'Normal');
x_values = 0:0.01:7;
y = pdf(pdFemale2019, x_values);
plot(x_values,y,'k','LineWidth',2)
ylim([0 0.4]); 
hold on
% Female2020
pdFemale2020 = fitdist(grFem2020.erv_fa,'Normal');
x_values = 0:0.01:7;
y = pdf(pdFemale2020, x_values);
plot(x_values,y,'LineWidth',2)
hold on
% Male2019
pdMale2019 = fitdist(grMale2019.erv_fa,'Normal');
x_values = 0:0.01:7;
y = pdf(pdMale2019, x_values);
plot(x_values,y,'LineWidth',2)
hold on
% Male2020
pdMale2020 = fitdist(grMale2020.erv_fa,'Normal');
x_values = 0:0.01:7;
y = pdf(pdMale2020, x_values);
plot(x_values,y,'g','LineWidth',2)
legend('Female2019','Female2020','Male2019','Male2020')
xlabel('Attitude')
ylabel('Probability density function')

%% Physical intense minutes per week for each group (TIME)

PhysIntense_Female2019 = grFem2019.dag_zwa1 .* (grFem2019.tijd_zwa1_uur .* 60 + grFem2019.tijd_zwa1_min);
PhysIntense_Female2020 = grFem2020.dag_zwa1 .* (grFem2020.tijd_zwa1_uur .* 60 + grFem2020.tijd_zwa1_min);
PhysIntense_Male2019 = grMale2019.dag_zwa1 .* (grMale2019.tijd_zwa1_uur .* 60 + grMale2019.tijd_zwa1_min);
PhysIntense_Male2020 = grMale2020.dag_zwa1 .* (grMale2020.tijd_zwa1_uur .* 60 + grMale2020.tijd_zwa1_min);

meanPhysIntense_Female2019 = mean(PhysIntense_Female2019);
meanPhysIntense_Female2020 = mean(PhysIntense_Female2020);
meanPhysIntense_Male2019 = mean(PhysIntense_Male2019);
meanPhysIntense_Male2020 = mean(PhysIntense_Male2020);

stdPhysIntense_Female2019 = std(PhysIntense_Female2019);
stdPhysIntense_Female2020 = std(PhysIntense_Female2020);
stdPhysIntense_Male2019 = std(PhysIntense_Male2019);
stdPhysIntense_Male2020 = std(PhysIntense_Male2020);

%% Moderate intense minutes per week for each group (TIME)

Moderate_Female2019 = grFem2019.dag_mat1 .* (grFem2019.tijd_mat1_uur .* 60 + grFem2019.tijd_mat1_min);
Moderate_Female2020 = grFem2020.dag_mat1 .* (grFem2020.tijd_mat1_uur .* 60 + grFem2020.tijd_mat1_min);
Moderate_Male2019 = grMale2019.dag_mat1 .* (grMale2019.tijd_mat1_uur .* 60 + grMale2019.tijd_mat1_min);
Moderate_Male2020 = grMale2020.dag_mat1 .* (grMale2020.tijd_mat1_uur .* 60 + grMale2020.tijd_mat1_min);
Moderate_Male2020(Moderate_Male2020 > 4000, :) = [];

meanModerate_Female2019 = mean(Moderate_Female2019);
meanModerate_Female2020 = mean(Moderate_Female2020);
meanModerate_Male2019 = mean(Moderate_Male2019);
meanModerate_Male2020 = mean(Moderate_Male2020);

stdModerate_Female2019 = std(Moderate_Female2019);
stdModerate_Female2020 = std(Moderate_Female2020);
stdModerate_Male2019 = std(Moderate_Male2019);
stdModerate_Male2020 = std(Moderate_Male2020);

%% Walking minutes per week for each group (TIME)

Walking_Female2019 = grFem2019.dag_wan1 .* (grFem2019.tijd_wan1_uur .* 60 + grFem2019.tijd_wan1_min);
Walking_Female2019(Walking_Female2019 > 1000, :) = [];
Walking_Female2020 = grFem2020.dag_wan1 .* (grFem2020.tijd_wan1_uur .* 60 + grFem2020.tijd_wan1_min);
Walking_Male2019 = grMale2019.dag_wan1 .* (grMale2019.tijd_wan1_uur .* 60 + grMale2019.tijd_wan1_min);
Walking_Male2020 = grMale2020.dag_wan1 .* (grMale2020.tijd_wan1_uur .* 60 + grMale2020.tijd_wan1_min);
Walking_Male2020(Walking_Male2020 > 10000, :) = [];

meanWalking_Female2019 = mean(Walking_Female2019);
meanWalking_Female2020 = mean(Walking_Female2020);
meanWalking_Male2019 = mean(Walking_Male2019);
meanWalking_Male2020 = mean(Walking_Male2020);

stdWalking_Female2019 = std(Walking_Female2019);
stdWalking_Female2020 = std(Walking_Female2020);
stdWalking_Male2019 = std(Walking_Male2019);
stdWalking_Male2020 = std(Walking_Male2020);

%% Sitting during a weekday (TIME)

Sitting_Female2019 = 7 .* (grFem2019.tijd_zwa1_uur .* 60 + grFem2019.tijd_zwa1_min);
Sitting_Female2020 = 7 .* (grFem2020.tijd_zwa1_uur .* 60 + grFem2020.tijd_zwa1_min);
Sitting_Male2019 = 7 .* (grMale2019.tijd_zwa1_uur .* 60 + grMale2019.tijd_zwa1_min);
Sitting_Male2020 = 7.* (grMale2020.tijd_zwa1_uur .* 60 + grMale2020.tijd_zwa1_min);

meanSitting_Female2019 = mean(Sitting_Female2019);
meanSitting_Female2020 = mean(Sitting_Female2020);
meanSitting_Male2019 = mean(Sitting_Male2019);
meanSitting_Male2020 = mean(Sitting_Male2020);

stdSitting_Female2019 = std(Sitting_Female2019);
stdSitting_Female2020 = std(Sitting_Female2019);
stdSitting_Male2019 = std(Sitting_Female2019);
stdSitting_Male2020 = std(Sitting_Female2019);

%% IPAQ TOTAL SCORE

grFem2019(grFem2019.ipaqtot1 > 10000, :) = [];
IPAQ_Female2019 = grFem2019.ipaqtot1;
% first, the rows with NAN need to be deleted
IPAQ_Female2019(isnan(IPAQ_Female2019))= 0;
IPAQ_Female2019(all(~IPAQ_Female2019,2),:) = [];

IPAQ_Female2020 = grFem2020.ipaqtot1;
% first, the rows with NAN need to be deleted
IPAQ_Female2020(isnan(IPAQ_Female2020))= 0;
IPAQ_Female2020(all(~IPAQ_Female2020,2),:) = [];

IPAQ_Male2019 = grMale2019.ipaqtot1;
% first, the rows with NAN need to be deleted
IPAQ_Male2019(isnan(IPAQ_Male2019))= 0;
IPAQ_Male2019(all(~IPAQ_Male2019,2),:) = [];

IPAQ_Male2020 = grMale2020.ipaqtot1;
% first, the rows with NAN need to be deleted
IPAQ_Male2020(isnan(IPAQ_Male2020))= 0;
IPAQ_Male2020(all(~IPAQ_Male2020,2),:) = [];

%% Attitude Unpaired t-test (different number of participants)

[hx,px] = ttest2(grFem2019.erv_fa,grFem2020.erv_fa);
[hy,py] = ttest2(grMale2019.erv_fa,grMale2020.erv_fa);

%% Activity Unpaired t-test (different number of participants)

[h1,p1] = ttest2(PhysIntense_Female2019,PhysIntense_Female2020);
[h2,p2] = ttest2(Moderate_Female2019,Moderate_Female2020);
[h3,p3] = ttest2(Walking_Female2019,Walking_Female2020);
[h4,p4] = ttest2(Sitting_Female2019,Sitting_Female2020);
[h5,p5] = ttest2(PhysIntense_Male2019,PhysIntense_Male2020);
[h6,p6] = ttest2(Moderate_Male2019,Moderate_Male2020);
[h7,p7] = ttest2(Walking_Male2019,Walking_Male2020);
[h8,p8] = ttest2(Sitting_Male2019,Sitting_Male2020);

%% TABLE WOMEN ATTITUDE

T1w = [meanAttF2019 stdAttF2019 
       meanAttF2020 stdAttF2020  
       px 0]

%% TABLE MEN ATTITUDE

T1m = [meanAttM2019 stdAttM2019 
       meanAttM2020 stdAttM2020
       py 0]

%% ABLE WOMEN ACTIVITY

T2w = [meanPhysIntense_Female2019 stdPhysIntense_Female2019 meanPhysIntense_Female2020 stdPhysIntense_Female2020 p1;
       meanModerate_Female2019 stdModerate_Female2019 meanModerate_Female2020 stdModerate_Female2020 p2;
       meanWalking_Female2019 stdWalking_Female2019 meanWalking_Female2020 stdWalking_Female2020 p3;
       meanSitting_Female2019 stdSitting_Female2019 meanSitting_Female2020 stdSitting_Female2020 p4]

%% TABLE MEN ACTIVITY
T2m = [meanPhysIntense_Male2019 stdPhysIntense_Male2019 meanPhysIntense_Male2020 stdPhysIntense_Male2020 p5;
       meanModerate_Male2019 stdModerate_Male2019 meanModerate_Male2020 stdModerate_Male2020 p6;
       meanWalking_Male2019 stdWalking_Male2019 meanWalking_Male2020 stdWalking_Male2020 p7;
       meanSitting_Male2019 stdSitting_Male2019 meanSitting_Male2020 stdSitting_Male2020 p8]
   
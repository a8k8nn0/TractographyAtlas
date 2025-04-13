%%  make TF data & dataset for making movie
clear

ID={'GROUP'};

% *** Change current directory to that including movie scripts ***
cd(['C:\script'])

% *** set directory ***
fsadir =  'C:\script\fsaverage';
savedir = (['C:\Cortical_Movies\GROUP\Onset']);
if ~exist(savedir,'dir')
    mkdir(savedir);
end
% ****** movie setting *********
radius_r = 100;
radius_k = 200;
Num_Thre = 1; % each effectve area needs this number of electrodes at least　3
Band = 'High_gamma';
Exclude = {'bad' 'onset' 'spiking'};
% ******************************
% *** import dataset ***
data1 = load('C:\demodata\Group_Comp_on_Dataset.mat'); % Left 3D brain
data2 = load('C:\demodata\Group_Comp_on_Dataset.mat'); % Right 3D brain
% **********************
% 
A=data1.Dataset(:,'effect'); A=table2array(A); %
A=A-1; A(A<0)=1;
A=logical(A);
data1.Dataset(A,:)=[];
data1.Data.Band_percentchange(A,:,:)=[];
data1.Data.Label(A,:)=[];
data1.Data.ID(A,:)=[];
data2.Dataset(A,:)=[];
data2.Data.Band_percentchange(A,:,:)=[];
data2.Data.ID(A,:)=[];

clear A;

% *** make data & dataset ***
data = data1.Data.Band_percentchange(:,:,strcmp(data1.Data.Band_name,Band));
data = cat(3,data,data2.Data.Band_percentchange(:,:,strcmp(data2.Data.Band_name,Band)));
Dataset = data1.Dataset; Dataset.Properties.VariableNames{1} = 'ID'; Dataset.Properties.VariableNames{2} = 'Side';
ind_exclude = isnan(Dataset{:,'fsaverage'}) | sum(Dataset{:,Exclude},2) > 0 ;
data(ind_exclude,:,:) = [];
Dataset(ind_exclude,:) = [];
time = data1.Data.Time;

% *** make dataset for HGA animation on 3D brain *** 
savename = fullfile(savedir,['Datasets_k' num2str(radius_k) '_r' num2str(radius_r) '_Threshold_' num2str(Num_Thre)]); %'Threshold' or 'Thresould'
[Data Setting] = Making_dataset_ms_ak2(data,time,Dataset,fsadir,savename,radius_r,radius_k,Num_Thre);

%% generate movie 

% ***** set condition ********************
fontsize = 1; %4
Title = 'Comp-onset';
left_name = 'Auditory';
right_name = 'Auditory';
amp_color_range=[-20 20]; %-20 20
Timeunit = 10; % ms
% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
movie_time_range =[-200 +500]; % noted in ms. -200 +500
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
Snapshot_time = [220 450] ; % snapshot time range, noted in ms.-300 -200 -100 0 100 200 300 400 500
% ****************************************
% *** generate movie ***
Generating_movies_ms_CYR(Data,Setting,fsadir,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time) %ms_Highは高解像度
%%  make TF data & dataset for making movie
clear

ID={'GROUP'};

% *** Change current directory to that including movie scripts ***
cd(['C:\script'])

% *** set directory ***
fsadir =  'C:\script\fsaverage';
savedir = (['C:\Cortical_Movies\GROUP\Offset']);
if ~exist(savedir,'dir')
    mkdir(savedir);
end
% ****** movie setting *********
radius_r = 100;
radius_k = 200;
Num_Thre = 1; % each effectve area needs this number of electrodes at least　3
Band = 'High_gamma';
Exclude = {'bad' 'onset' 'spiking'};
% ******************************
% *** import dataset ***
data1 = load('C:\demodata\Group_Comp_off_Dataset.mat'); % Left 3D brain
data2 = load('C:\demodata\Group_Comp_off_Dataset.mat'); % Right 3D brain
% **********************
% 
A=data1.Dataset(:,'effect'); A=table2array(A); %
A=A-1; A(A<0)=1;
A=logical(A);
data1.Dataset(A,:)=[];
data1.Data.Band_percentchange(A,:,:)=[];
data1.Data.Label(A,:)=[];
data1.Data.ID(A,:)=[];
data2.Dataset(A,:)=[];
data2.Data.Band_percentchange(A,:,:)=[];
data2.Data.ID(A,:)=[];

clear A;

% *** make data & dataset ***
data = data1.Data.Band_percentchange(:,:,strcmp(data1.Data.Band_name,Band));
data = cat(3,data,data2.Data.Band_percentchange(:,:,strcmp(data2.Data.Band_name,Band)));
Dataset = data1.Dataset; Dataset.Properties.VariableNames{1} = 'ID'; Dataset.Properties.VariableNames{2} = 'Side';
ind_exclude = isnan(Dataset{:,'fsaverage'}) | sum(Dataset{:,Exclude},2) > 0 ;
data(ind_exclude,:,:) = [];
Dataset(ind_exclude,:) = [];
time = data1.Data.Time;

% *** make dataset for HGA animation on 3D brain *** 
savename = fullfile(savedir,['Datasets_k' num2str(radius_k) '_r' num2str(radius_r) '_Threshold_' num2str(Num_Thre)]); %'Threshold' or 'Thresould'
[Data Setting] = Making_dataset_ms_ak2(data,time,Dataset,fsadir,savename,radius_r,radius_k,Num_Thre);

%% generate movie 

% ***** set condition ********************
fontsize = 1; %4
Title = 'Comp-offset';
left_name = 'Auditory';
right_name = 'Auditory';
amp_color_range=[-20 20]; %-20 20
Timeunit = 10; % ms
% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
movie_time_range =[-500 +500]; % noted in ms. -200 +500
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
Snapshot_time = [60] ; % snapshot time range, noted in ms.-300 -200 -100 0 100 200 300 400 500
% ****************************************
% *** generate movie ***
Generating_movies_ms_CYR(Data,Setting,fsadir,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time) %ms_Highは高解像度
%%  make TF data & dataset for making movie
clearvars -except ID
% *** Change current directory to that including movie scripts ***
cd('C:\script')

% *** set directory ***
fsadir =  'C:\script\fsaverage';
savedir = (['C:\Cortical_Movies\GROUP\Response']);
if ~exist(savedir,'dir')
    mkdir(savedir);
end
% ****** movie setting *********
radius_r = 100;
radius_k = 200;
Num_Thre = 1; % each effectve area needs this number of electrodes at least　3
Band = 'High_gamma';
Exclude = {'bad' 'onset' 'spiking'};
% ******************************
% *** import dataset ***
data1 = load('C:\demodata\Group_Resp_on_Dataset.mat'); % Left 3D brain
data2 = load('C:\demodata\Group_Resp_on_Dataset.mat'); % Right 3D brain
% **********************
% 
A=data1.Dataset(:,'effect'); A=table2array(A); %
A=A-1; A(A<0)=1;
A=logical(A);
data1.Dataset(A,:)=[];
data1.Data.Band_percentchange(A,:,:)=[];
data1.Data.Label(A,:)=[];
data1.Data.ID(A,:)=[];
data2.Dataset(A,:)=[];
data2.Data.Band_percentchange(A,:,:)=[];
data2.Data.ID(A,:)=[];

clear A;

% *** make data & dataset ***
data = data1.Data.Band_percentchange(:,:,strcmp(data1.Data.Band_name,Band));
data = cat(3,data,data2.Data.Band_percentchange(:,:,strcmp(data2.Data.Band_name,Band)));
Dataset = data1.Dataset; Dataset.Properties.VariableNames{1} = 'ID'; Dataset.Properties.VariableNames{2} = 'Side';
ind_exclude = isnan(Dataset{:,'fsaverage'}) | sum(Dataset{:,Exclude},2) > 0 ;
data(ind_exclude,:,:) = [];
Dataset(ind_exclude,:) = [];
time = data1.Data.Time;

% *** make dataset for HGA animation on 3D brain *** 
savename = fullfile(savedir,['Datasets_k' num2str(radius_k) '_r' num2str(radius_r) '_Threshold_' num2str(Num_Thre)]); %'Threshold' or 'Thresould'
[Data Setting] = Making_dataset_ms_ak2(data,time,Dataset,fsadir,savename,radius_r,radius_k,Num_Thre);

%% STEP6-2 generate movie 

% ***** set condition ********************
fontsize = 1; %4
Title = 'Resp-onset';
left_name = 'Auditory';
right_name = 'Auditory';
amp_color_range=[-20 20]; %-20 20
Timeunit = 10; % ms
% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
movie_time_range =[-500 500]; % noted in ms. 
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
Snapshot_time = [-380 -50 200 430] ; % snapshot time range, noted in ms.
% ****************************************
% *** generate movie ***
Generating_movies_ms_CYR(Data,Setting,fsadir,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time) %ms_Highは高解像度
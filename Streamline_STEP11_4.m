%% STEP11 Movie
% 
clear;

addpath('C:\script');
addpath('C:\fieldtrip-20250318');
addpath('C:\fieldtrip-20250318\utilities');
addpath('C:\fieldtrip-20250318\plotting')
%

clear;
% set parameter **************
bands = {'HG'}; % 
tasks = {'Comp_on'}; %
stat = '9999CI'; %
span = 200;
method = 'both'; %

for band=bands
    band = cell2mat(band);
    for task=tasks
        task=cell2mat(task)

% ****** set movie parameter ******
Connect_thres = 0.5 ;
min_transparency = 0.5; %
% tract parameter
NF = '1000';
NS = '500000';
NSK = strcat(num2str(str2num(NS)/1000), 'k');
thres = '0.05';
SS = '0';
% ****************************
datadir = ['C:\STEP10_MovieData\Auditory_' task '\'];
savedir = ['C:\STEP11_TractMovie\Auditory_' task '\']; 
if ~exist(savedir,'dir')
    mkdir(savedir)
end

cd(savedir);

savename = fullfile(savedir,['tract_' ...
    stat '_' method '_' band '_' task '_' NSK '_fa_threshold_' num2str(thres) '_stepsize_' num2str(SS)]);

% load tract data
Tract1 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']);
Tract2 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']); % 

% ***** set condition ********************
fontsize = 1; % for font, 6

if task == 'Comp-on'
    left_name = 'Comp-on';
else
    left_name = 'Comp-on';
end
right_name = left_name;%

% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
if task=='Comp-on'
movie_time_range =[-200 500];
else
    movie_time_range =[-200 500];
end
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
if task=='Comp-on'
Snapshot_time = [220 450]; %
else %
    Snapshot_time = [220 450];
end

% ************************************************************************************
% ************************************************************************************
amp_color_range=[-1 1];  % = transparency
Timeunit = 10; % 

Side1 = Tract1.Data.tract_name;
Side2 = Tract2.Data.tract_name;
Setting.fnum = size(Tract1.Data.Alpha,2);
Setting.Time_all = Tract1.Data.time;

Alpha1 = Tract1.Data.Alpha';
Alpha2 = Tract2.Data.Alpha';
Tract_1 = Tract1.Tract;
Tract_2 = Tract2.Tract;

%

Title = ['connectivity'];

[ftver, ftpath] = ft_version;
mesh_lh = load([ftpath filesep 'template/anatomy/surface_pial_left.mat']);
mesh_rh = load([ftpath filesep 'template/anatomy/surface_pial_right.mat']);

name1=Tract1.Data.tract_name; name1=name1';
idx1 = strfind(name1,'left'); idx2 = strfind(name1,'right');
TF1=~cellfun(@isempty,idx1); TF2=~cellfun(@isempty,idx2);
TF3=TF1+TF2; TF3(TF3<2)=0; TF3(TF3==2)=1; %
TF3=logical(TF3);

name2=Tract2.Data.tract_name; name2=name2';
idx4 = strfind(name2,'left'); idx5 = strfind(name2,'right');
TF4=~cellfun(@isempty,idx4); TF5=~cellfun(@isempty,idx5);
TF6=TF4+TF5; TF6(TF6<2)=0; TF6(TF6==2)=1; %
TF6=logical(TF6);

% *** generate movie ***
Generating_movies_DTI_ks4yk7ak1_intra_inter_mixed(Alpha1,Alpha2,Setting,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time,Tract_1,Tract_2,mesh_lh,mesh_rh,Side1,Side2,TF3,TF6)
    end

end
%% STEP11 Movie
% 
clear;

addpath('C:\script');
addpath('C:\fieldtrip-20250318');
addpath('C:\fieldtrip-20250318\utilities');
addpath('C:\fieldtrip-20250318\plotting')
%

clear;
% set parameter **************
bands = {'HG'}; %
tasks = {'Comp_off'}; % 
stat = '9999CI'; % 
span = 200;
method = 'both'; % 

for band=bands
    band = cell2mat(band);
    for task=tasks
        task=cell2mat(task)

% ****** set movie parameter ******
Connect_thres = 0.5 ;
min_transparency = 0.5; %
% tract parameter
NF = '1000';
NS = '500000';
NSK = strcat(num2str(str2num(NS)/1000), 'k');
thres = '0.05';
SS = '0';
% ****************************
datadir = ['C:\STEP10_MovieData\Auditory_' task '\'];
savedir = ['C:\STEP11_TractMovie\Auditory_' task '\']; 
if ~exist(savedir,'dir')
    mkdir(savedir)
end

cd(savedir);

savename = fullfile(savedir,['tract_' ...
    stat '_' method '_' band '_' task '_' NSK '_fa_threshold_' num2str(thres) '_stepsize_' num2str(SS)]);

% load tract data
Tract1 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']);
Tract2 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']); % 

% ***** set condition ********************
fontsize = 1; % for font, 6

if task == 'Comp-off'
    left_name = 'Comp-off';
else
    left_name = 'Comp-off';
end
right_name = left_name;%

% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
if task=='Comp-off'
movie_time_range =[-500 500];
else
    movie_time_range =[-500 500];
end
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
if task=='Comp-off'
Snapshot_time = [60]; %
else %
    Snapshot_time = [60];
end

% ************************************************************************************
% ************************************************************************************
amp_color_range=[-1 1];  % = transparency
Timeunit = 10; % 

Side1 = Tract1.Data.tract_name;
Side2 = Tract2.Data.tract_name;
Setting.fnum = size(Tract1.Data.Alpha,2);
Setting.Time_all = Tract1.Data.time;

Alpha1 = Tract1.Data.Alpha';
Alpha2 = Tract2.Data.Alpha';
Tract_1 = Tract1.Tract;
Tract_2 = Tract2.Tract;

%

Title = ['connectivity'];

[ftver, ftpath] = ft_version;
mesh_lh = load([ftpath filesep 'template/anatomy/surface_pial_left.mat']);
mesh_rh = load([ftpath filesep 'template/anatomy/surface_pial_right.mat']);

name1=Tract1.Data.tract_name; name1=name1';
idx1 = strfind(name1,'left'); idx2 = strfind(name1,'right');
TF1=~cellfun(@isempty,idx1); TF2=~cellfun(@isempty,idx2);
TF3=TF1+TF2; TF3(TF3<2)=0; TF3(TF3==2)=1; %
TF3=logical(TF3);

name2=Tract2.Data.tract_name; name2=name2';
idx4 = strfind(name2,'left'); idx5 = strfind(name2,'right');
TF4=~cellfun(@isempty,idx4); TF5=~cellfun(@isempty,idx5);
TF6=TF4+TF5; TF6(TF6<2)=0; TF6(TF6==2)=1; %
TF6=logical(TF6);

% *** generate movie ***
Generating_movies_DTI_ks4yk7ak1_intra_inter_mixed(Alpha1,Alpha2,Setting,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time,Tract_1,Tract_2,mesh_lh,mesh_rh,Side1,Side2,TF3,TF6)
    end

end
%% STEP11 Movie
% 
clear;

addpath('C:\script');
addpath('C:\fieldtrip-20250318');
addpath('C:\fieldtrip-20250318\utilities');
addpath('C:\fieldtrip-20250318\plotting')
%

clear;
% set parameter **************
bands = {'HG'}; % 
tasks = {'Resp_on'}; % 
stat = '9999CI'; % 
span = 200;
method = 'both'; % 

for band=bands
    band = cell2mat(band);
    for task=tasks
        task=cell2mat(task)

% ****** set movie parameter ******
Connect_thres = 0.5 ;
min_transparency = 0.5; %
% tract parameter
NF = '1000';
NS = '500000';
NSK = strcat(num2str(str2num(NS)/1000), 'k');
thres = '0.05';
SS = '0';
% ****************************
datadir = ['C:\STEP10_MovieData\Auditory_' task '\'];
savedir = ['C:\STEP11_TractMovie\Auditory_' task '\']; 
if ~exist(savedir,'dir')
    mkdir(savedir)
end

cd(savedir);

savename = fullfile(savedir,['tract_' ...
    stat '_' method '_' band '_' task '_' NSK '_fa_threshold_' num2str(thres) '_stepsize_' num2str(SS)]);

% load tract data
Tract1 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']);
Tract2 = load([datadir, 'tract_' stat '_' method '_' band '_' task '.mat']); % ditto

% ***** set condition ********************
fontsize = 1; % for font, 6

if task == 'Resp-on'
    left_name = 'Resp-on';
else
    left_name = 'Resp-on';
end
right_name = left_name;%

% *** for movie ***
Export_Movie = 1; % 1 = generate movie file
if task=='Resp-on'
movie_time_range =[-500 500];
else
    movie_time_range =[-500 500];
end
frame_number=3; % Increase the frame number if you want to slow motion.

% *** for snapshots ***
Export_Fig = 1;% 1 = generate snapshot file
if task=='Resp-on'
Snapshot_time = [-380 -50 430]; % 
else %
    Snapshot_time = [-380 -50 430];
end

% ************************************************************************************
% ************************************************************************************
amp_color_range=[-1 1];  % = transparency
Timeunit = 10; % 

Side1 = Tract1.Data.tract_name;
Side2 = Tract2.Data.tract_name;
Setting.fnum = size(Tract1.Data.Alpha,2);
Setting.Time_all = Tract1.Data.time;

Alpha1 = Tract1.Data.Alpha';
Alpha2 = Tract2.Data.Alpha';
Tract_1 = Tract1.Tract;
Tract_2 = Tract2.Tract;

%

Title = ['connectivity'];

[ftver, ftpath] = ft_version;
mesh_lh = load([ftpath filesep 'template/anatomy/surface_pial_left.mat']);
mesh_rh = load([ftpath filesep 'template/anatomy/surface_pial_right.mat']);

name1=Tract1.Data.tract_name; name1=name1';
idx1 = strfind(name1,'left'); idx2 = strfind(name1,'right');
TF1=~cellfun(@isempty,idx1); TF2=~cellfun(@isempty,idx2);
TF3=TF1+TF2; TF3(TF3<2)=0; TF3(TF3==2)=1; %
TF3=logical(TF3);

name2=Tract2.Data.tract_name; name2=name2';
idx4 = strfind(name2,'left'); idx5 = strfind(name2,'right');
TF4=~cellfun(@isempty,idx4); TF5=~cellfun(@isempty,idx5);
TF6=TF4+TF5; TF6(TF6<2)=0; TF6(TF6==2)=1; %
TF6=logical(TF6);

% *** generate movie ***
Generating_movies_DTI_ks4yk7ak1_intra_inter_mixed(Alpha1,Alpha2,Setting,savename,amp_color_range,Timeunit,frame_number,movie_time_range,fontsize,Title,left_name,right_name,Export_Movie,Export_Fig,Snapshot_time,Tract_1,Tract_2,mesh_lh,mesh_rh,Side1,Side2,TF3,TF6)
    end

end

%% STEP7

clear;
list={'Comp_on','Resp_on','Comp_off'}; %{'Comp_on','Resp_on','Comp_off'}
for side={'Lt','Rt'} %{'Lt'} {'Rt'}
 
for t=1:size(list,2) %:size(list,2) %t=1 or t=2
n2=char(list(t));
for k=1:31 
bin_width = 10;
dname1 = ['C:\demodata\Group_' n2 '_Dataset.mat'];
savedir = ['C:\STEP7_Single\Auditory_' n2 '\'];

if ~exist(savedir,'dir')
    mkdir(savedir)
end

Side = char(side);
Condition = n2;
ROI_Num = k;

switch Condition
    case 'Comp_on';Tmin=-200; Tmax=1800; bin=[41:241];
    case 'Comp_off';Tmin=-2600; Tmax=1400; bin=[1:401];    
    case 'Resp_on';Tmin=-1000; Tmax=1000; bin=[101:301];
end

Twindow=[Tmin:10:Tmax];        
Time_range =[Tmin Tmax]; % 

switch ROI_Num
    case 1; ROI='caudalanteriorcingulate'; case 2; ROI='caudalmiddlefrontal'; case 3; ROI='cuneus'; case 4; ROI='entorhinal'; case 5; ROI='fusiform';
    case 6; ROI='inferiorparietal'; case 7; ROI='inferiortemporal'; case 8; ROI='isthmuscingulate'; case 9; ROI='lateraloccipital'; case 10; ROI='lateralorbitofrontal';
    case 11; ROI='lingual'; case 12; ROI='medialorbitofrontal'; case 13; ROI='middletemporal'; case 14; ROI='parahippocampal'; case 15; ROI='paracentral';
    case 16; ROI='parsopercularis'; case 17; ROI='parsorbitalis'; case 18; ROI='parstriangularis'; case 19; ROI='pericalcarine'; case 20; ROI='postcentral';
    case 21; ROI='posteriorcingulate'; case 22; ROI='precentral'; case 23; ROI='precuneus'; case 24; ROI='rostralanteriorcingulate'; case 25; ROI='rostralmiddlefrontal';
    case 26; ROI='superiorfrontal'; case 27; ROI='superiorparietal'; case 28; ROI='superiortemporal'; case 29; ROI='supramarginal'; case 30; ROI='transversetemporal';
    case 31; ROI='insula';
        
end
%% 2.99.99%CI(w/o bootstrap)
% calculate CI
load(dname1);

%
%if ROI_Num == 27;
%    ind1=strcmp(Dataset.label,'entorhinal');
%    ind2=strcmp(Dataset.label,'parahippocampal');
%    Dataset(ind1,'label')={'medialtemporal'};
%    Dataset(ind2,'label')={'medialtemporal'};
%    clear ind1 ind2
%else
%end

%
A=Dataset(:,'effect'); A=table2array(A); %
A=A-1; A(A<0)=1;
A=logical(A);
Dataset(A,:)=[];
Data.Band_percentchange(A,:,:)=[];
Data.Label(A,:)=[];
Data.ID(A,:)=[];
clear A;

d1 = Data.Band_percentchange(strcmp(Dataset.LR,Side) & strcmp(Dataset.label,ROI),:,2);
whole_bin=size(Data.Time,2);
check=table2cell(Dataset);
check=check((strcmp(Dataset.LR,Side) & strcmp(Dataset.label,ROI)),:);

CI = [];
SD=std(d1); %
SE=SD/sqrt(size(d1,1)); %
NF=3.89*SE; %d1 SE*3.89=99.99%CI

CI(1,:)=mean(d1)-NF; %
CI(2,:)=mean(d1)+NF; %
if size(d1,1)==1
    CI=NaN(2,size(d1,2));
end
Data.CI_HGA = CI;
%% Sig_Aug

testdata=CI(:,bin); %

testdata_low=testdata(1,:); %
testdata_low(testdata_low>0)=1; %
testdata_low(testdata_low<0)=0; %

a = find([0 testdata_low] ~= 0);%
switch isempty(a) %
    case 1; vs=[];ve=[];vs_sig=[]; %
    case 0; %

vs = a(find(diff([0 a]) > 1))-1;%
ve = [a(find(diff(a) > 1)) a(end)]-1;%
gap=ve-vs+1; %
gap_sig=gap; gap_sig(gap<=4)=[]; %
ve_sig=ve; ve_sig(gap<=4)=[]; %
vs_sig=vs; vs_sig(gap<=4)=[]; %
end
switch isempty(vs_sig) %
    case 1; disp('sig_aug is zero.'); Caug=[]; %
    case 0; %
        n=numel(vs_sig); %
if n==1 %
Caug=[vs_sig(1,1):ve_sig(1,1)];
else 
for i=1:n; %
Caug{i}=[vs_sig(1,i):ve_sig(1,i)];%
end
Caug=cell2mat(Caug); %
end
end

testdata_aug=zeros(1,(max(bin)-min(bin)+1));%
testdata_aug(Caug)=1; %

A=zeros(1,(min(bin)-1)); %
B=zeros(1,(max(whole_bin)-(max(bin)+1)+1)); %
testdata_aug=[A testdata_aug B]; %

clear A B Caug

%% Sig_Att

clear ve ve_sig vs vs_sig gap gap_sig a

testdata_high=testdata(2,:); %
testdata_high(testdata_high>0)=0; %
testdata_high(testdata_high<0)=-1; %

b = find([0 testdata_high] ~= 0);%
switch isempty(b) %
    case 1; vs=[];ve=[];vs_sig=[]; %
    case 0; %

vs = b(find(diff([0 b]) > 1))-1;%
ve = [b(find(diff(b) > 1)) b(end)]-1;%
gap=ve-vs+1; %
gap_sig=gap; gap_sig(gap<=4)=[]; %
ve_sig=ve; ve_sig(gap<=4)=[]; %
vs_sig=vs; vs_sig(gap<=4)=[]; %
end
switch isempty(vs_sig) %
    case 1; disp('sig_att is zero.'); Catt=[]; %
    case 0; %
        n=numel(vs_sig); %
if n==1 %
Catt=[vs_sig(1,1):ve_sig(1,1)];
else 
for i=1:n; %
Catt{i}=[vs_sig(1,i):ve_sig(1,i)];%
end
Catt=cell2mat(Catt); %
end
end

testdata_att=zeros(1,(max(bin)-min(bin)+1));% 
testdata_att(Catt)=-1; %

A=zeros(1,(min(bin)-1)); %
B=zeros(1,(max(whole_bin)-(max(bin)+1)+1)); %
testdata_att=[A testdata_att B]; %

clear A B Catt

%% 

clear ve ve_sig vs vs_sig gap gap_sig b
testdata_sig=testdata_aug+testdata_att;

if t==1 %
    testdata_sig(:,1:60)=0;
else
end
T=testdata_sig;
T=T(bin);
Taug=T;
Taug(Taug<0)=0;

Tatt=T;
Tatt(Tatt>0)=0;

Taug_sum=sum(Taug);%
Tatt_sum=sum(Tatt);%
%%
Color1 =[0.3010 0.7450 0.9330];
if size(d1,1)==1
    d1_mean=NaN(2,size(d1,2));
else
    d1_mean=mean(d1);
end
Fig = figure;
plotshaded2(Twindow,CI(:,bin),Color1); hold on;
plot(Twindow,d1_mean(:,bin),'Color',Color1);hold on

xlim(Time_range);
L=min(CI(1,bin)); U=max(CI(2,bin));
ylim = [round(L-10,-1) round(U+10,-1)];

% bar
T_plot=testdata_sig(bin);
T_plot(T_plot==0)=NaN; %
T_plot(T_plot==1)=ylim(2)*0.93; %
T_plot(T_plot==-1)=ylim(1)*0.93;
plot(Twindow,T_plot,'k','LineWidth',1);hold on
xline(0,'k--');hold on
yline(0,'k--');hold on
box on;

%title(string([Side '_' ROI]),'Interpreter','none');
ax = gca; ax.FontSize = 4;
ax = gca; ax.YTickLabel = cell(size(ax.YTickLabel)); ax.XTickLabel = cell(size(ax.XTickLabel));
set(gcf,'PaperUnits','inches','PaperPosition',[1.8 1.8 1.8 1.8]); %
print(Fig,[savedir Side '_' ROI '.png'],'-dpng','-r900'); %
saveas(Fig,[savedir Side '_' ROI '.fig']);
close(Fig)
save([savedir Side '_' ROI '_CI.mat'],'Data','Dataset','testdata_sig','Taug_sum','Tatt_sum')
clearvars -except t ROI Side x d1 Time_range Condition Task1 T_plot Color1 Amp_range list s n1 n2 side check;
end
end
end
%% STEP9
% 
clear;
bands = {'HG'}; %
tasks = {'Comp_on','Comp_off','Resp_on'}; %
stat = '9999CI'; % 
% tract parameter
method = 'both'; % 
NF = '1000';
NS = '500000';
NSK = strcat(num2str(str2num(NS)/1000), 'k');
thres = '0.05';
SS = '0';
% **************************
for band = bands
   band = cell2mat(band);
for t2=1:size(tasks,2) %s2
task=cell2mat(tasks(t2));

datadir=(['C:\STEP8_Dual\Auditory_' task '\']);
savedir= ['C:\STEP9_Tract\Auditory_' task '\'];
if ~exist(savedir,'dir')
    mkdir(savedir)
end
tractdir=('C:\streamline_template\');

dlist_pre1=readcell([datadir 'Co_aug_sig_chart.xlsx']); Sub_name1=dlist_pre1(2:end,3);
dlist_pre2=readcell([datadir 'Co_att_sig_chart.xlsx']); Sub_name2=dlist_pre2(2:end,3);
Sub_name=vertcat(Sub_name1,Sub_name2);

            for o = 1:size(Sub_name,1)
                s = Sub_name(o);
                ss = cell2mat(s);
                sss = find(ismember(Sub_name,ss));
                if strcmp(method,'both')
                    d = dir([tractdir, '*_' ss '_' NSK '_fa_threshold' '_' thres '_' 'stepsize_' SS '.mat']);
                elseif strcmp(method,'ROI2ROI')
                    d = dir([tractdir, 'ROI2ROI_' ss '_' NSK '_fa_threshold' '_' thres '_' 'stepsize_' SS '.mat']);
                elseif strcmp(method,'SEED2ROI')
                    d = dir([tractdir, 'SEED2ROI_' ss '_' NSK '_fa_threshold' '_' thres '_' 'stepsize_' SS '.mat']);
                end
                if ~isempty(d)
                    if length(d) ==1
                        load([tractdir,d.name]);
                        tracts2 = tracts;
                        Tr = [];
                        for j = 1:size(length,2) % size(length,2)
                            jj = length(j);
                            tr = tracts2(:,1:jj); %
                            tracts2(:,1:jj) = []; %
                            Tr = cat(2,Tr,{tr});
                            clear jj tr
                        end
                        TR = Tr;
                        clear tracts2 tracts length Tr

                    elseif length(d) ==2
                        TR = [];
                        for i = 1:2
                            load([tractdir,d(i).name]);
                            tracts2 = tracts;
                            Tr = [];
                            for j = 1:size(length,2) % size(length,2)
                                jj = length(j);
                                tr = tracts2(:,1:jj); % 
                                tracts2(:,1:jj) = []; % 
                                Tr = cat(2,Tr,{tr});
                                clear jj tr
                            end
                            TR = cat(2,TR,Tr); % 
                            clear tracts2 tracts length Tr
                        end
                    end

                    %
                    LE = [];
                    for j = 1:size(TR,2)
                        jj = TR(j);
                        jjj = cell2mat(jj)';

                        % the shortest tract
                        Le = [];
                        for k = 1:size(jjj,1)-1
                            le = sqrt((jjj(k,1) - jjj(k+1,1))^2 + (jjj(k,2) -  jjj(k+1,2))^2 + (jjj(k,3) - jjj(k+1,3))^2); %
                            %
                            Le = cat(2,Le,le);
                            clear le
                        end
                        Le = sum(Le);
                        LE = cat(2,LE,Le);
                        clear Le jj jjj
                    end
                    [B,I] = min(LE);
                    p_tracts = cell2mat(TR(I));
                    % modify coordinate *******
                    p_tracts(1,:) = -(p_tracts(1,:))+78;
                    p_tracts(2,:) = -(p_tracts(2,:))+76;
                    p_tracts(3,:) = p_tracts(3,:)-50;
                    % **************************************
                    p_tracts = p_tracts';
                    save(fullfile(savedir,['shortest_' stat '_' method '_' ss '_' band '_' task '.mat']),'p_tracts','-v7.3');
                    clear LE B I TR d ss sss
                end
            end
end
end

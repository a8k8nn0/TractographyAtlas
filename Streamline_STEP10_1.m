%% STEP10: set transparency of Co-XX data
% 
clear;
% set parameter **************
bands = {'HG'}; % 'HG','beta'
tasks = {'Comp_on','Comp_off','Resp_on'}; %
stat = '9999CI'; % 'FDR'
span = 200;
method = 'both'; % 

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

    for band = bands
        band = cell2mat(band);
        for t2=1:size(tasks,2) %s2
        task=cell2mat(tasks(t2));
            
            datadir=(['C:\STEP8_Dual\Auditory_' task '\']);
            tractdir= ['C:\STEP9_Tract\Auditory_' task '\'];
            savedir=(['C:\STEP10_MovieData\Auditory_' task '\']);
            if ~exist(savedir,'dir')
                mkdir(savedir)
            end

           dlist_pre1=readcell([datadir 'Co_aug_sig_chart.xlsx']); Sub_name1=dlist_pre1(2:end,3);
           dlist_pre2=readcell([datadir 'Co_att_sig_chart.xlsx']); Sub_name2=dlist_pre2(2:end,3);
           Sub_name=vertcat(Sub_name1,Sub_name2);

            tract_name = [];
            Val = [];
            Tract = [];
            for o = 1:size(Sub_name,1)
                s = Sub_name(o);
                ss = cell2mat(s);
                sss = find(ismember(Sub_name,ss));
                t = dir([tractdir,'shortest_' stat '_' method '_' ss '_' band '_' task '.mat']);
                if ~isempty(t)
                    tract = load([tractdir,'shortest_' stat '_' method '_' ss '_' band '_' task '.mat']);
                    load([datadir, ss '.mat']);
                    val = Co_mod50; % merge
                    tract_name = cat(1,tract_name,cellstr(ss));
                    Val = cat(1,Val,val);
                    Tract = cat(1,Tract,{tract.p_tracts});
                    clear val
                end
                clear ss sss tract t
            end
            time= Co_mod50_length ; clear Co_mod50 Co_mod50_length

            % adjust transparency *******************
            ALPHA = [];
            for j = 1:size(Val,1)
                data = Val(j,:); %
                data(abs(data)<Connect_thres) = 0;
                Abs = abs(data);
                diff = linspace(Connect_thres,1,Connect_thres*100+1);
                trans = linspace(min_transparency,1,Connect_thres*100+1);
                Alpha = zeros(1,size(Abs,2));
                for a = 1:size(Abs,2)
                    A = Abs(a);
                    if ~(A == 0) & ~isnan(A)
                        [B,I] = min(abs(diff-A));
                        C = trans(I);
                        Alpha(a) = C;
                        clear A B C I
                    end
                end
                M = find(data < 0);
                Alpha(M) = -(Alpha(M));
                ALPHA = cat(1,ALPHA,Alpha);
                clear data Abs diff trans Alpha
            end
            % ****************************************
            Data.tract_name = tract_name;
            Data.time = time;
            Data.Alpha = ALPHA;
            clear tract_name time Val ALPHA

            % save tract and transparency information
            save(fullfile(savedir,['tract_' ...
                stat '_' method '_' band '_' task '.mat']),'Tract','Data','-v7.3');
            clear Tract Data
        end
    end

    % reset
    clc
    close all
    
    % functions path
    addpath(sprintf('%s',strcat(pwd,'\functions')));
    addpath(sprintf('%s',strcat(pwd,'\functions\eeglab')));
    
    % this tracks which version of EEGLAB is being used, you may ignore it
    % run the 'eeglab' command once!
    EEG.etc.eeglabvers = '14.0.0';
    
    % parameters
    reload = 'true';
    n_subjects = 20;
    
    Epoch_timelim_all = [[0;4]];
    Epoch_timelim_bef = [[-2;0] [-1;1] [0;2] [1;3]];
    Epoch_timelim_aft = [[1;2] [2;3] [3;4] [4;5]];
    Confusion_matrix = zeros(2,3,[]);
    Accuracy = zeros(1,[]);
    counter = 0;
    for epoch_timelim_all = Epoch_timelim_all
        for epoch_timelim_bef = Epoch_timelim_bef
            for epoch_timelim_aft = Epoch_timelim_aft
                counter = counter + 1;
                [Confusion_matrix(:,:,counter),Accuracy(:,counter)] = run(reload,n_subjects,epoch_timelim_all,epoch_timelim_bef,epoch_timelim_aft);
            end
        end
    end
    
    display(Confusion_matrix);
    display(Accuracy);
    
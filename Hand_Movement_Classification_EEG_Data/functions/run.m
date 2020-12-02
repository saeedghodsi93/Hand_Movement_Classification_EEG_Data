function [ confusion_matrix,accuracy ] = run( reload,n_subjects,epoch_timelim_all,epoch_timelim_bef,epoch_timelim_aft )

    if strcmp(reload,'true')
        
        % process each sample
        subjects = [1:n_subjects];
        runs = [3,7,11];
        features = zeros([],[]);
        targets = zeros([],1);
        counter = 0;
        
        for subject_idx = subjects
            display(subject_idx);
            for run_idx = runs
                display(run_idx);
                EEG = load_dataset(subject_idx,run_idx);
                [EEG_lall,EEG_rall,EEG_lerd,EEG_rerd,EEG_lers,EEG_rers,EEG_lmrcp,EEG_rmrcp] = preprocess(EEG,epoch_timelim_all,epoch_timelim_bef,epoch_timelim_aft);
                [features,targets,counter] = feature_extraction(EEG_lall,EEG_lerd,EEG_lers,EEG_lmrcp,1,features,targets,counter);
                [features,targets,counter] = feature_extraction(EEG_rall,EEG_rerd,EEG_rers,EEG_rmrcp,2,features,targets,counter);
                
            end
        end
        
        save('file.mat','features','targets');
        
    elseif strcmp(reload,'false')
        
        load('file.mat','features','targets');
        
    end
    
    confusion_matrix = classification(features,targets);
    accuracy = (confusion_matrix(1,1) + confusion_matrix(2,2)) / sum(sum(confusion_matrix));
    display(confusion_matrix);
    display(accuracy);
    
end

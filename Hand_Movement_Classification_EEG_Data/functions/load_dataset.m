function [ EEG ] = load_dataset( subject_idx,run_idx )

    % load the EDF file
    cd dataset
    
    edf_addr = sprintf('S%dR%d.edf',subject_idx,run_idx);
    EEG = pop_biosig(edf_addr);
    EEG = eeg_checkset(EEG);
    
    cd ..
    
end

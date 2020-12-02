function [ EEG_lall,EEG_rall,EEG_lerd,EEG_rerd,EEG_lers,EEG_rers,EEG_lmrcp,EEG_rmrcp ] = preprocess( EEG,epoch_timelim_all,epoch_timelim_bef,epoch_timelim_aft )
    
    disp('Pre-Processing...');
    
    % parameters
    bp_fl = 0.5;
    bp_fh = 60;
    bp_order = 1200;

    no_fl = 45;
    no_fh = 55;
    no_order = 200;

    eog_wl = [1];
    eog_ws = [0.5];
    eog_eigratio = [1e6];
    eog_crit_opt = [2 10];

    fs = [160];
    emg_wl = [10];
    emg_ws = [2];
    emg_eigratio = [1e6];
    emg_ratio = [10];
    emg_femg = [15];
    emg_crit_opt = [0 10];
    
    mubeta_fl = 8;
    mubeta_fh = 30;
    delta_fl = 0.5;
    delta_fh = 3;
    iso_order = 1200;

    baseline = [-100 0];
    
    % channel selection
    EEG = pop_select( EEG,'channel',{'Fc3.' 'Fcz.' 'Fc4.' 'C3..' 'C1..' 'Cz..' 'C2..' 'C4..'});
    EEG = eeg_checkset( EEG );

    % band pass filter
    EEG = pop_eegfiltnew(EEG,bp_fl,bp_fh,bp_order,0);
    EEG = eeg_checkset(EEG);

    % notch filter
    EEG = pop_eegfiltnew(EEG,no_fl,no_fh,no_order,1);
    EEG = eeg_checkset(EEG);

    % AAR EOG removal
    EEG = pop_autobsseog(EEG, eog_wl, eog_ws, 'iwasobi', {'eigratio',eog_eigratio}, 'eog_fd', {'range',eog_crit_opt});
    EEG = eeg_checkset(EEG);

    % AAR EMG removal
    EEG = pop_autobssemg(EEG, emg_wl, emg_ws, 'bsscca', {'eigratio',emg_eigratio}, 'emg_psd', {'ratio', emg_ratio,'fs', fs,'femg', emg_femg,'estimator',spectrum.welch({'Hamming'}, 80),'range',emg_crit_opt});
    EEG = eeg_checkset(EEG);

    % rhythm isolation
    EEG_lerd = pop_eegfiltnew(EEG,mubeta_fl,mubeta_fh,iso_order,0);
    EEG_lerd = eeg_checkset(EEG_lerd);

    EEG_rerd = pop_eegfiltnew(EEG,mubeta_fl,mubeta_fh,iso_order,0);
    EEG_rerd = eeg_checkset(EEG_rerd);

    EEG_lers = pop_eegfiltnew(EEG,mubeta_fl,mubeta_fh,iso_order,0);
    EEG_lers = eeg_checkset(EEG_lers);

    EEG_rers = pop_eegfiltnew(EEG,mubeta_fl,mubeta_fh,iso_order,0);
    EEG_rers = eeg_checkset(EEG_rers);

    EEG_lmrcp = pop_eegfiltnew(EEG,delta_fl,delta_fh,iso_order,0);
    EEG_lmrcp = eeg_checkset(EEG_lmrcp);

    EEG_rmrcp = pop_eegfiltnew(EEG,delta_fl,delta_fh,iso_order,0);
    EEG_rmrcp = eeg_checkset(EEG_rmrcp);

    % epoch extraction
    type = {'2'};
    EEG_lall = pop_epoch(EEG, type, epoch_timelim_all);
    EEG_lall = eeg_checkset(EEG_lall);
%     EEG_lerd = pop_rmbase(EEG_lerd, baseline);
%     EEG_lerd = eeg_checkset(EEG_lerd);

    type = {'3'};
    EEG_rall = pop_epoch(EEG, type, epoch_timelim_all);
    EEG_rall = eeg_checkset(EEG_rall);
%     EEG_rerd = pop_rmbase(EEG_rerd, baseline);
%     EEG_rerd = eeg_checkset(EEG_rerd);

    type = {'2'};
    EEG_lerd = pop_epoch(EEG_lerd, type, epoch_timelim_bef);
    EEG_lerd = eeg_checkset(EEG_lerd);
    EEG_lerd = pop_rmbase(EEG_lerd, baseline);
    EEG_lerd = eeg_checkset(EEG_lerd);

    type = {'3'};
    EEG_rerd = pop_epoch(EEG_rerd, type, epoch_timelim_bef);
    EEG_rerd = eeg_checkset(EEG_rerd);
    EEG_rerd = pop_rmbase(EEG_rerd, baseline);
    EEG_rerd = eeg_checkset(EEG_rerd);

    type = {'2'};
    EEG_lers = pop_epoch(EEG_lers, type, epoch_timelim_aft);
    EEG_lers = eeg_checkset(EEG_lers);
%             EEG_lers = pop_rmbase(EEG_lers, baseline);
%             EEG_lers = eeg_checkset(EEG_lers);

    type = {'3'};
    EEG_rers = pop_epoch(EEG_rers, type, epoch_timelim_aft);
    EEG_rers = eeg_checkset(EEG_rers);
%             EEG_rers = pop_rmbase(EEG_rers, baseline);
%             EEG_rers = eeg_checkset(EEG_rers);

    type = {'2'};
    EEG_lmrcp = pop_epoch(EEG_lmrcp, type, epoch_timelim_bef);
    EEG_lmrcp = eeg_checkset(EEG_lmrcp);
    EEG_lmrcp = pop_rmbase(EEG_lmrcp, baseline);
    EEG_lmrcp = eeg_checkset(EEG_lmrcp);

    type = {'3'};
    EEG_rmrcp = pop_epoch(EEG_rmrcp, type, epoch_timelim_bef);
    EEG_rmrcp = eeg_checkset(EEG_rmrcp);
    EEG_rmrcp = pop_rmbase(EEG_rmrcp, baseline);
    EEG_rmrcp = eeg_checkset(EEG_rmrcp);

    % ICA
    EEG_lerd = pop_runica(EEG_lerd, 'extended',1,'interupt','off');
    EEG_lerd = eeg_checkset( EEG_lerd );

    EEG_rerd = pop_runica(EEG_rerd, 'extended',1,'interupt','off');
    EEG_rerd = eeg_checkset( EEG_rerd );

    EEG_lers = pop_runica(EEG_lers, 'extended',1,'interupt','off');
    EEG_lers = eeg_checkset( EEG_lers );

    EEG_rers = pop_runica(EEG_rers, 'extended',1,'interupt','off');
    EEG_rers = eeg_checkset( EEG_rers );

    EEG_lmrcp = pop_runica(EEG_lmrcp, 'extended',1,'interupt','off');
    EEG_lmrcp = eeg_checkset( EEG_lmrcp );

    EEG_rmrcp = pop_runica(EEG_rmrcp, 'extended',1,'interupt','off');
    EEG_rmrcp = eeg_checkset( EEG_rmrcp );
            
    
    % plot
%     pop_eegplot( EEG, 1, 1, 1);
%     pop_eegplot( EEG, 0, 1, 1);

end


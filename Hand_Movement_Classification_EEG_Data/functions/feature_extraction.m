function [ features,targets,counter ] = feature_extraction( EEG_all,EEG_erd,EEG_ers,EEG_mrcp,target,features,targets,counter )
        
    epoch_length = 640;
    wavelet_level = 2;
    wavelet_name = 'dmey';
    
    % feature extraction
    signals = EEG_all.data;
%     weights = EEG.icaweights;
%     signals = weights * signals;
    channels_power = zeros(1,size(signals,1));
    channels_mean = zeros(1,size(signals,1));
    channels_var = zeros(1,size(signals,1));
    channels_entropy = zeros(1,size(signals,1));
    channels_wavelet = zeros([],size(signals,1));
    for c = 1:size(signals,1)
        po = 0;
        me = 0;
        va = 0;
        en = 0;
        for e = 1:1
            signal = double(signals(c,:,e));
            po = po + bandpower(signal);
            me = me + mean(signal);
            va = va + var(signal);
            en = en + wentropy(signal,'shannon');
            signal = resample(signal,epoch_length,size(signal,2));
            wa = wavedec(signal,wavelet_level,wavelet_name);          
        end
        channels_power(1,c) = po/size(signals,3);
        channels_mean(1,c) = me/size(signals,3);
        channels_var(1,c) = va/size(signals,3);
        channels_entropy(1,c) = en/size(signals,3);
        channels_wavelet(1:size(wa,2),c) = wa';
    end
    channels_wavelet = reshape(channels_wavelet,1,size(channels_wavelet,1)*size(channels_wavelet,2));
    channels_correlation = zeros(size(signals,1),size(signals,1));
    for e = 1:size(signals,3)
        channels_correlation = channels_correlation + corrcoef(permute(signals(:,:,e),[2 1 3]))/size(signals,3);
    end
    channels_correlation = reshape(channels_correlation,1,size(channels_correlation,1)*size(channels_correlation,2));
    features_all = [channels_power,channels_mean,channels_var,channels_entropy,channels_correlation,channels_wavelet];
    
    % feature extraction
    signals = EEG_erd.data;
%     weights = EEG.icaweights;
%     signals = weights * signals;
    channels_power = zeros(1,size(signals,1));
    channels_mean = zeros(1,size(signals,1));
    channels_var = zeros(1,size(signals,1));
    channels_entropy = zeros(1,size(signals,1));
    channels_wavelet = zeros([],size(signals,1));
    for c = 1:size(signals,1)
        po = 0;
        me = 0;
        va = 0;
        en = 0;
        for e = 1:1
            signal = double(signals(c,:,e));
            po = po + bandpower(signal);
            me = me + mean(signal);
            va = va + var(signal);
            en = en + wentropy(signal,'shannon');
            signal = resample(double(signal),epoch_length,size(signal,2));
            wa = wavedec(signal,wavelet_level,wavelet_name);          
        end
        channels_power(1,c) = po/size(signals,3);
        channels_mean(1,c) = me/size(signals,3);
        channels_var(1,c) = va/size(signals,3);
        channels_entropy(1,c) = en/size(signals,3);
        channels_wavelet(1:size(wa,2),c) = wa';
    end
    channels_wavelet = reshape(channels_wavelet,1,size(channels_wavelet,1)*size(channels_wavelet,2));
    channels_correlation = zeros(size(signals,1),size(signals,1));
    for e = 1:size(signals,3)
        channels_correlation = channels_correlation + corrcoef(permute(signals(:,:,e),[2 1 3]))/size(signals,3);
    end
    channels_correlation = reshape(channels_correlation,1,size(channels_correlation,1)*size(channels_correlation,2));
    features_erd = [channels_power,channels_mean,channels_var,channels_entropy,channels_correlation,channels_wavelet];
    
    signals = EEG_ers.data;
%     weights = EEG.icaweights;
%     signals = weights * signals;
    channels_power = zeros(1,size(signals,1));
    channels_mean = zeros(1,size(signals,1));
    channels_var = zeros(1,size(signals,1));
    channels_entropy = zeros(1,size(signals,1));
    channels_wavelet = zeros([],size(signals,1));
    for c = 1:size(signals,1)
        po = 0;
        me = 0;
        va = 0;
        en = 0;
        for e = 1:1
            signal = double(signals(c,:,e));
            po = po + bandpower(signal);
            me = me + mean(signal);
            va = va + var(signal);
            en = en + wentropy(signal,'shannon');
            signal = resample(signal,epoch_length,size(signal,2));
            wa = wavedec(signal,wavelet_level,wavelet_name);          
        end
        channels_power(1,c) = po/size(signals,3);
        channels_mean(1,c) = me/size(signals,3);
        channels_var(1,c) = va/size(signals,3);
        channels_entropy(1,c) = en/size(signals,3);
        channels_wavelet(1:size(wa,2),c) = wa';
    end
    channels_wavelet = reshape(channels_wavelet,1,size(channels_wavelet,1)*size(channels_wavelet,2));
    channels_correlation = zeros(size(signals,1),size(signals,1));
    for e = 1:size(signals,3)
        channels_correlation = channels_correlation + corrcoef(permute(signals(:,:,e),[2 1 3]))/size(signals,3);
    end
    channels_correlation = reshape(channels_correlation,1,size(channels_correlation,1)*size(channels_correlation,2));
    features_ers = [channels_power,channels_mean,channels_var,channels_entropy,channels_correlation,channels_wavelet];
    
    signals = EEG_mrcp.data;
%     weights = EEG.icaweights;
%     signals = weights * signals;
    channels_power = zeros(1,size(signals,1));
    channels_mean = zeros(1,size(signals,1));
    channels_var = zeros(1,size(signals,1));
    channels_entropy = zeros(1,size(signals,1));
    channels_wavelet = zeros([],size(signals,1));
    for c = 1:size(signals,1)
        po = 0;
        me = 0;
        va = 0;
        en = 0;
        for e = 1:1
            signal = double(signals(c,:,e));
            po = po + bandpower(signal);
            me = me + mean(signal);
            va = va + var(signal);
            en = en + wentropy(signal,'shannon');
            signal = resample(signal,epoch_length,size(signal,2));
            wa = wavedec(signal,wavelet_level,wavelet_name);          
        end
        channels_power(1,c) = po/size(signals,3);
        channels_mean(1,c) = me/size(signals,3);
        channels_var(1,c) = va/size(signals,3);
        channels_entropy(1,c) = en/size(signals,3);
        channels_wavelet(1:size(wa,2),c) = wa';
    end
    channels_wavelet = reshape(channels_wavelet,1,size(channels_wavelet,1)*size(channels_wavelet,2));
    channels_correlation = zeros(size(signals,1),size(signals,1));
    for e = 1:size(signals,3)
        channels_correlation = channels_correlation + corrcoef(permute(signals(:,:,e),[2 1 3]))/size(signals,3);
    end
    channels_correlation = reshape(channels_correlation,1,size(channels_correlation,1)*size(channels_correlation,2));
    features_mrcp = [channels_power,channels_mean,channels_var,channels_entropy,channels_correlation,channels_wavelet];
    
    % add to the feature vectors
    counter = counter + 1;
    features(counter,1:size(features_erd,2)+size(features_ers,2)+size(features_mrcp,2)) = [features_erd,features_ers,features_mrcp];
%     features(counter,1:size(features_all,2)) = [features_all];
    targets(counter,1) = target;
    
end

%             
%             % feature extraction
%             signals = EEG_rerd.data;
%             weights = EEG_rerd.icaweights;
%             signals = weights * signals;
%             channels_power = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + sum(signal.^2);
%                 end
%                 channels_power(1,c) = p/size(signals,3);
%             end
%             channels_energy = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + bandpower(signal);
%                 end
%                 channels_energy(1,c) = p/size(signals,3);
%             end
%             channels_mean = zeros(size(signals,1),1);
%             for c = 1:size(signals,1)
%                 m = 0;
%                 for e = 1:size(signals,3)
%                     m = m + mean(signal);
%                 end
%                 channels_mean(c,1) = m/size(signals,3);
%             end
%             type = 1;
%             target = 2;
%             
%             % add to the feature vectors
%             counter = counter + 1;
%             features(counter,1:17) = [channels_power,channels_energy,type];
%             targets(counter,1) = target;
%             
%             % feature extraction
%             signals = EEG_lers.data;
%             weights = EEG_lers.icaweights;
%             signals = weights * signals;
%             channels_power = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + sum(signal.^2);
%                 end
%                 channels_power(1,c) = p/size(signals,3);
%             end
%             channels_energy = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + bandpower(signal);
%                 end
%                 channels_energy(1,c) = p/size(signals,3);
%             end
%             channels_mean = zeros(size(signals,1),1);
%             for c = 1:size(signals,1)
%                 m = 0;
%                 for e = 1:size(signals,3)
%                     m = m + mean(signal);
%                 end
%                 channels_mean(c,1) = m/size(signals,3);
%             end
%             type = 2;
%             target = 1;
%             
%             % add to the feature vectors
%             counter = counter + 1;
%             features(counter,1:17) = [channels_power,channels_energy,type];
%             targets(counter,1) = target;
%             
%             % feature extraction
%             signals = EEG_rers.data;
%             weights = EEG_rers.icaweights;
%             signals = weights * signals;
%             channels_power = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + sum(signal.^2);
%                 end
%                 channels_power(1,c) = p/size(signals,3);
%             end
%             channels_energy = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + bandpower(signal);
%                 end
%                 channels_energy(1,c) = p/size(signals,3);
%             end
%             channels_mean = zeros(size(signals,1),1);
%             for c = 1:size(signals,1)
%                 m = 0;
%                 for e = 1:size(signals,3)
%                     m = m + mean(signal);
%                 end
%                 channels_mean(c,1) = m/size(signals,3);
%             end
%             type = 2;
%             target = 2;
%             
%             % add to the feature vectors
%             counter = counter + 1;
%             features(counter,1:17) = [channels_power,channels_energy,type];
%             targets(counter,1) = target;
%             
%             % feature extraction
%             signals = EEG_lmrcp.data;
%             weights = EEG_lmrcp.icaweights;
%             signals = weights * signals;
%             channels_power = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + sum(signal.^2);
%                 end
%                 channels_power(1,c) = p/size(signals,3);
%             end
%             channels_energy = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + bandpower(signal);
%                 end
%                 channels_energy(1,c) = p/size(signals,3);
%             end
%             channels_mean = zeros(size(signals,1),1);
%             for c = 1:size(signals,1)
%                 m = 0;
%                 for e = 1:size(signals,3)
%                     m = m + mean(signal);
%                 end
%                 channels_mean(c,1) = m/size(signals,3);
%             end
%             type = 3;
%             target = 1;
%             
%             % add to the feature vectors
%             counter = counter + 1;
%             features(counter,1:17) = [channels_power,channels_energy,type];
%             targets(counter,1) = target;
%             
%             % feature extraction
%             signals = EEG_rmrcp.data;
%             weights = EEG_rmrcp.icaweights;
%             signals = weights * signals;
%             channels_power = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + sum(signal.^2);
%                 end
%                 channels_power(1,c) = p/size(signals,3);
%             end
%             channels_energy = zeros(1,size(signals,1));
%             for c = 1:size(signals,1)
%                 p = 0;
%                 for e = 1:size(signals,3)
%                     p = p + bandpower(signal);
%                 end
%                 channels_energy(1,c) = p/size(signals,3);
%             end
%             channels_mean = zeros(size(signals,1),1);
%             for c = 1:size(signals,1)
%                 m = 0;
%                 for e = 1:size(signals,3)
%                     m = m + mean(signal);
%                 end
%                 channels_mean(c,1) = m/size(signals,3);
%             end
%             type = 3;
%             target = 2;
%             
%             % add to the feature vectors
%             counter = counter + 1;
%             features(counter,1:17) = [channels_power,channels_energy,type];
%             targets(counter,1) = target;


%     channels_energy = zeros(1,size(signals,1));
%     for c = 1:size(signals,1)
%         p = 0;
%         for e = 1:size(signals,3)
%             p = p + sum(signal.^2);
%         end
%         channels_energy(1,c) = p/size(signals,3);
%     end
%     channels_mean = zeros(size(signals,1),1);
%     for c = 1:size(signals,1)
%         m = 0;
%         for e = 1:size(signals,3)
%             m = m + mean(signal);
%         end
%         channels_mean(c,1) = m/size(signals,3);
%     end
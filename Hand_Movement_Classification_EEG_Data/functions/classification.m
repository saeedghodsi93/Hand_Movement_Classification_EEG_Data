function [ confusion_matrix ] = classification( features,targets )
    disp('	Classification...');
    
    n_tests = 10;
    confusion_matrix = zeros(2,3);
    for t = 1:n_tests
        
        % partition to train and test sets
        idx = randperm(size(targets,1));
        pivot = round(0.8*size(targets,1));
        train_features = features(idx(1:pivot),:);
        train_targets = targets(idx(1:pivot),:);
        test_features = features(idx(pivot+1:end),:);
        test_targets = targets(idx(pivot+1:end),:);

        % train the classifier and predict test labels
        options = statset('UseParallel',true);
        classifier = TreeBagger(300,train_features,train_targets,'OOBPrediction','Off','Method','classification','Options',options);
%         classifier = fitcsvm(train_features,train_targets);
%         classifier=fitcdiscr(train_features,train_labels,'DiscrimType','linear');
%         classifier=fitcknn(train_features,train_labels,'NumNeighbors',1,'Distance','euclidean');
%         classifier=fitcknn(train_features,train_labels,'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',struct('AcquisitionFunctionName','expected-improvement-plus'));
%         t = templateNaiveBayes('Distribution','normal');
%         classifier=fitcecoc(train_features,train_labels,'Learners',t,'Options',options);
        predicted_labels = predict(classifier,test_features);

        if(iscell(predicted_labels))
            predicted_labels = cellfun(@str2num,predicted_labels);
        end
        
        % update confusion matrix
        for i = 1:size(predicted_labels,1)
            if isnan(predicted_labels(i)) || isinf(predicted_labels(i))
                confusion_matrix(test_targets(i),size(confusion_matrix,2)) = confusion_matrix(test_targets(i),size(confusion_matrix,2)) + 1;
            else
                confusion_matrix(test_targets(i),predicted_labels(i)) = confusion_matrix(test_targets(i),predicted_labels(i)) + 1;
            end
        end
        
    end
    
end

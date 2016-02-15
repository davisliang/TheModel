function [ output_args ] = PanquPCA(f_filtered_normalized_dwsp_vector_allsub_train,...
    f_filtered_normalized_dwsp_vector_allsub_test, numScales, numOrientations)
    %UNTITLED Summary of this function goes here
    %Detailed explanation goes here
    for scales=1:numScales
        scale_all(:,:,scales)=f_filtered_normalized_dwsp_vector_allsub_train((scales-1)*dwsp*dwsp*size(numOrientations,2)+1:scales*dwsp*dwsp*size(numOrientations,2),:);
        scale_all_test(:,:,scales)=f_filtered_normalized_dwsp_vector_allsub_test((scales-1)*dwsp*dwsp*size(numOrientations,2)+1:scales*dwsp*dwsp*size(numOrientations,2),:);
        mean_images(:,scales)=mean(scale_all(:,:,scales),2);    
        
        %turk and pentland trick, for each scale
        mean_subst(:,:,scales)=scale_all(:,:,scales)-repmat(mean_images(:,scales),1,total_train);
        mean_subst_test(:,:,scales)=scale_all_test(:,:,scales)-repmat(mean_images(:,scales),1,total_test);
        cov_scale=(mean_subst(:,:,scales)'*mean_subst(:,:,scales))*(1/total_train); %(estimate of covariance)
        [vector_temp value]=eig(cov_scale);
        vector_biggest=vector_temp(:,end-num_pca+1:end);
        
        %original principal components
        vector_ori(:,:,scales)=mean_subst(:,:,scales)*vector_biggest;

        %projection onto the basis vector vector_ori(dimension 512-dimension 8)
        %normal
        f_PCA_scale_normal=zscore(vector_ori(:,:,scales)'*mean_subst(:,:,scales));
        f_PCA_scale_test_normal=zscore(vector_ori(:,:,scales)'*mean_subst_test(:,:,scales));
        
%         f_PCA_scale_normal=(vector_ori(:,:,scales)'*mean_subst(:,:,scales));
%         f_PCA_scale_test_normal=(vector_ori(:,:,scales)'*mean_subst_test(:,:,scales));        
    
        f_PCA_temp_normal((scales-1)*num_pca+1:scales*num_pca,:)=f_PCA_scale_normal;
        f_PCA_test_temp_normal((scales-1)*num_pca+1:scales*num_pca,:)=f_PCA_scale_test_normal;
      
    end

end


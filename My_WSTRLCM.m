function out = My_WSTRLCM(dataset, num, tempo_num, top_diff, win_size)
    tem_data = dataset(:,:,num : num + 2 * tempo_num);
    current_frame = tem_data(:,:,1 + tempo_num);
    current_num = 1 + tempo_num;
    tep_current_frame_t1 = (ordfilt2(4*current_frame, 9, ones(3,3),'symmetric') + ...
                            3*ordfilt2(current_frame, 8, ones(3,3),'symmetric') + ...
                            2*ordfilt2(current_frame, 7, ones(3,3),'symmetric'))/9;

    tep_current_frame = normal(tep_current_frame_t1 + ...
        exp(-2/5)*max(tem_data(:,:,3) - tem_data(:,:,2), 0) + ...
        exp(-2/5)*max(tem_data(:,:,3) - tem_data(:,:,4), 0) + ...
        exp(-1/5)*max(tem_data(:,:,3) - tem_data(:,:,1), 0) + ...
        exp(-1/5)*max(tem_data(:,:,3) - tem_data(:,:,5), 0));
    
    Back_max = zeros(size(tem_data,1), size(tem_data,2), win_size);

    for j = 1:win_size
        mask1 = genCircle(j+1);
        mask_num = sum(sum(mask1));
        Back_max(:,:,j) = ordfilt2(tem_data(:,:,current_num), mask_num, mask1, 'symmetric');
    end
    array_current_frame = repmat(tep_current_frame, [1,1,win_size]);
    temporal_contrast = max(array_current_frame.*max(array_current_frame - Back_max, 0), [], 3);
    out = top_diff(:,:,num).*temporal_contrast;

    out_max = max(out(:));
    out_mean = mean(out(:));
    th = 0.15*out_max + 0.85*out_mean;
    out(out<th) = 0;
end
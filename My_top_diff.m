function top_diff = My_top_diff(dataset, seq_len)
    
    img = dataset(:,:,1);
    img_top = zeros(size(dataset,1), size(dataset,2),seq_len);
    for j = 1:seq_len
        img_top(:,:,j) = my_weight(dataset(:,:,j));
    end

    top_temp2 = zeros(size(img,1), size(img,2), seq_len);
    top_temp3 = zeros(size(img,1), size(img,2), seq_len);
    top_temp4 = zeros(size(img,1), size(img,2), seq_len);
    top_temp5 = zeros(size(img,1), size(img,2), seq_len);
    
    top_temp1 = img_top;
    top_temp2(:,:,1:end-1) = img_top(:,:,2:end);
    top_temp3(:,:,1:end-2) = img_top(:,:,3:end);
    top_temp4(:,:,1:end-3) = img_top(:,:,4:end);
    top_temp5(:,:,1:end-4) = img_top(:,:,5:end);
    
    top_diff1 = max(top_temp3 - top_temp1, 0);
    top_diff2 = max(top_temp3 - top_temp2, 0);
    top_diff3 = max(top_temp3 - top_temp4, 0);
    top_diff4 = max(top_temp3 - top_temp5, 0);
    
    top_diff = normal((top_diff1 + top_diff4) .* (top_diff2 + top_diff3));
end
function w = my_weight(img)

mask = [-1,-1,0,-1,-1;-1,0,3,0,-1;0,3,8,3,0;-1,0,3,0,-1;-1,-1,0,-1,-1];
Ori = max(0, imfilter(img, mask, 'replicate'));

sz = 2;
[lambda_1, lambda_2] = structure_tensor_lambda(img, sz);
weight = (lambda_1 .* (lambda_1 .* lambda_2) ./ (lambda_1 + lambda_2));

maxvalue = max(max(weight));
minvalue = min(min(weight));
weight = (weight - minvalue)/(maxvalue - minvalue);

Ori = Ori .*  weight;
w = Ori;
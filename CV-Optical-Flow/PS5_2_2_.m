

% Expanding and finding lapalacian

I=im2double(imread('yos1.jpg'));

n=3;

for i=1:n
 
    
  
    
I_reduce=reduce_func_LK(I,1);


I_expand=expand_func_LK(I_reduce,1);



if(size(I)~=size(I_expand))
    
 I=imresize(I,size(I_expand));

end


I_laplacian=I-I_expand;

figure,imshow(I_laplacian);


I=I_reduce;



end
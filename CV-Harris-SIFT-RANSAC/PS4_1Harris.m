

% Q1 Computing Harris Corners

clear all;

I=im2double(imread('simA.jpg'));

H=fspecial('gaussian',[3 3],1);

I_blur=imfilter(I,H,'replicate');
 
figure,imshow(I_blur);

[rows cols]=size(I_blur);


[Ix Iy]=imgradientxy(I_blur); % Gradient computation

figure,imshow(Ix);
 
figure,imshow(Iy);


I_adjoin=[Ix Iy];

r=1;
w=1;


figure,imshow(I_adjoin);  % Adjoining gradient images



R=zeros(480,640);



for i=2:(rows-1)
    
    
    for j=2:(cols-1)


w1(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)).^2)));    
  
w2(i,j)=sum(sum(w.*(Iy((i-r):(i+r),(j-r):(j+r)).^2)));       
        
w3(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)))*(Iy((i-r):(i+r),(j-r):(j+r)))));

M=[w1(i,j) w3(i,j);w3(i,j) w2(i,j)];  % Computing M
 
R(i,j)=det(M)-(0.4)*trace((M)^2);  % Computing R


    end
end

figure,
R=mat2gray(R,[0 1]);    % Displaying R and scaling it to [0,1]
imshow(R);



% Non maximal suppression

for i=2:(rows-1)
    
    for j=2:(cols-1)
      
 
   if(R(i,j)~=max(max(R(i-1:i+1,j-1:j+1))))  
 
       
       R(i,j)=0;
       
    end
end
  
end


% Thresholding

threshold=0.25;


for i=1:(rows)
    
   for j=1:(cols)    

if(R(i,j)<threshold)
    
    R(i,j)=0;
    
   end


end
end



% Displaying corner images

[Xp Yp]=find(R>0);

figure(2)
 imshow('simA.jpg');
 
 hold on
 
 plot(Yp,Xp,'o');
 
 hold off

   

        
        



    
   



%Q2.1

clear all
vr = VideoReader('pres_debate.avi');
numFrames = get(vr, 'NumberOfFrames');
vidobj=VideoWriter('pres_debate_hand.avi');
open(vidobj);

shapeInserter=vision.ShapeInserter;

N=35;

Xt=randsample(530:635,N);
Yt=randsample(380:700,N);



Xt_check=Xt;
Yt_check=Yt;

sigma2=0.2;


for k=1:numFrames

image = rgb2gray(im2double(read(vr,k)));
image2=rgb2gray(im2double(read(vr,1)));
image1= im2double(read(vr,k));

[X Y]=size(image);


if(k==1)
    
 Unew=530;
 Vnew=380;


elseif(k==2)   % Made a change here

%Computing MSE of randomly selected particels

for i=1:N

k=Xt(i)-ceil(120/2);

k1=Yt(i)-ceil(80/2);

MSE(i)=sum(sum((1/(80*120))*((image2(530:610,380:500)-image(k:k+80,k1:k1+120).^2))));

end

elseif(k==3)
    
for(i=1:N)
    
temp=(sigma2)*image2(530:610,380:500)+ (1-sigma2)*image((Unew:Unew+80),(Vnew:Vnew+120));
  
MSE(i)=sum(sum(((1/(80*120))*(((temp)-image((Unew:(Unew+80)),(Vnew:Vnew+120))).^2))));
 
end

else
    
for(i=1:N)
 
temp=(sigma2)*temp + (1-sigma2)*image((Unew:Unew+80),(Vnew:Vnew+120));
 
MSE(i)=sum(sum(((1/(80*120))*(((temp)-image((Unew:(Unew+80)),(Vnew:Vnew+120))).^2))));
     
end

%Adding Gaussian noise

if(k~=1)
    
for i=1:N
    
 sigma=0.45;

Pzt_xt(i)=exp(-MSE(i)/(2*(sigma)^2));

end


norm_factor=sum(Pzt_xt);

Pzt_xt=Pzt_xt./(norm_factor);



[val,Index]=max(Pzt_xt);

Unew=Xt(Index)-ceil(80/2);
Vnew=Yt(Index)-ceil(120/2);

Unew=awgn(Unew,randsample(-25:25,1));

Vnew=awgn(Vnew,randsample(-25:25,1));

end

% shapeInserter=vision.ShapeInserter;

rectangle=[Unew Vnew 120 80];


frame=step(shapeInserter,image1,rectangle);

writeVideo(vidobj,frame);


%resampling particles


if(k~=1)

A=[Pzt_xt];

Xt1=randsample(Xt,N,'true',A);
Yt1=randsample(Yt,N,'true',A);


end

end

end
close(vidobj);

implay('pres_debate_hand.avi');

%%%%%%%% Extracting frames%%%%%%%%


K=imread('pres_debate140_template.jpg');

figure,
imshow(K);

hold on 

plot(Xt1,Yt1,'go');

hold off





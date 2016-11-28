
% Q3- RANSAC


%%%%%%$ Harris corner detection %%%%%%%%%%


clear all;

I=im2double(imread('transA.jpg'));

I1=single(imread('transA.jpg'));

H=fspecial('gaussian',[3 3],1);

I_blur=imfilter(I,H,'replicate');
 

[rows cols]=size(I_blur);


[Ix Iy]=imgradientxy(I_blur);


 
I_adjoin=[Ix Iy];

r=1;

w=1;




R=zeros(480,640);



for i=2:(rows-1)
    
    
for j=2:(cols-1)


w1(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)).^2)));    
  
w2(i,j)=sum(sum(w.*(Iy((i-r):(i+r),(j-r):(j+r)).^2)));       
        
w3(i,j)=sum(sum(w.*(Ix((i-r):(i+r),(j-r):(j+r)))*(Iy((i-r):(i+r),(j-r):(j+r)))));
 

M=[w1(i,j) w3(i,j);w3(i,j) w2(i,j)];

 
R(i,j)=det(M)-(0.4)*trace((M)^2);




end
end

%figure,
%imshow(R,[min(min(R)) max(max(R))]);



for i=2:(rows-1)
    
    for j=2:(cols-1)
        

 
   if(R(i,j)~=max(max(R(i-1:i+1,j-1:j+1))))  
 
       
       R(i,j)=0;
       
end
end
  
end


threshold=0.25;


for i=1:(rows)
    
for j=1:(cols)    

if(R(i,j)<threshold)
    
    R(i,j)=0;
    
   end


end



end


[Xp Yp]=find(R>0);

% figure,
% imshow('simA.jpg');
% 
% hold on
% 
% plot(Yp,Xp,'o');
% 
% hold off


%%%%%%%%%%%% SIFT Implementation of 1st image %%%%%%%%


% Computing angle image

for i=1:rows
    
    
    for j=1:cols
        

     angle(i,j)=atan2(Iy(i,j),Ix(i,j));   
        
        
    end
end



% Computing interest points with gradients

figure(1)

imshow('transA.jpg');

hold on
    
for i=1:size(Xp,1)
    
Z=[Yp(i);Xp(i)];

d=angle(Xp(i),Yp(i));


F_in(1:4,i)=[Z;3;d];



h=vl_plotframe(F_in(1:4,i));
 
set(h,'linewidth',1);

end

hold off


[F_out,D_out]=vl_sift(I1,'frames',F_in);


% figure(2)
% 
% imshow('simB.jpg');
% hold on












%%%%%%%%%%%%%%%%%%%%% Second image   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%% Harris corner detection with second image

Ib=im2double(imread('transB.jpg'));

I1b=single(imread('transB.jpg'));

H1=fspecial('gaussian',[3 3],1);

I_blurb=imfilter(Ib,H1,'replicate');
 


[rows1 cols1]=size(I_blurb);


[Ixb Iyb]=imgradientxy(I_blurb);


r1=1;
w1=1;



R1=zeros(480,640);



for i=2:(rows1-1)
    
    
for j=2:(cols1-1)


w11(i,j)=sum(sum(w1.*(Ixb((i-r1):(i+r1),(j-r1):(j+r1)).^2)));    
  
w22(i,j)=sum(sum(w1.*(Iyb((i-r1):(i+r1),(j-r1):(j+r1)).^2)));       
        
w33(i,j)=sum(sum(w1.*(Ixb((i-r1):(i+r1),(j-r1):(j+r1)))*(Iyb((i-r1):(i+r1),(j-r1):(j+r1)))));
 

M1=[w11(i,j) w33(i,j);w33(i,j) w22(i,j)];

 
R1(i,j)=det(M1)-(0.4)*trace((M1)^2);




end
end


%Non maximal suppression



for i=2:(rows1-1)
    
    for j=2:(cols1-1)
        

 
   if(R1(i,j)~=max(max(R1(i-1:i+1,j-1:j+1))))  
 
       
       R1(i,j)=0;
       
end
end
  
end

% Thresholding

threshold=0.25;


for i=1:(rows1)
    
for j=1:(cols1)    

if(R1(i,j)<threshold)
    
    R1(i,j)=0;
    
   end


end



end


[Xpb Ypb]=find(R1>0);

% figure,
% imshow('simA.jpg');
% 
% hold on
% 
% plot(Yp,Xp,'o');
% 
% hold off


%%%%%%%%%% SIFT Implementation of second image%%%%

% Finding angle image

for i=1:rows1
    
    
    for j=1:cols1
        

     angle(i,j)=atan2(Iyb(i,j),Ixb(i,j));   
        
        
    end
end


% Computing interest points with gradient direction

figure(2)

imshow('transB.jpg');

hold on
    
for i=1:size(Xpb,1)
    
Z1=[Ypb(i);Xpb(i)];

d1=angle(Xpb(i),Ypb(i));


F_in1(1:4,i)=[Z1;3;d1];

h1=vl_plotframe(F_in1(1:4,i));
 
set(h1,'linewidth',1);

end

hold off


[F_outb,D_outb]=vl_sift(I1b,'frames',F_in1);


[M_ubc,S_ubc] = vl_ubcmatch(D_out,D_outb); % Finding matches

 
Ic=[I Ib];

figure(3)
imshow(Ic);

hold on

for i=1:size(M_ubc,2)
    
ka(1:4,i)=F_out(:,M_ubc(1,i));    

kb(1:4,i)=F_outb(:,M_ubc(2,i));


% plot([ka(1,1),(kb(1,1)+640)],[ka(2,1),kb(2,1)]);

end

hold off

%%%%%%% Implementation for RANSAC; Finding Consesnus%%%%%%

k=1:size(M_ubc,2);  

m=k(randi(numel(k)));  % Randomly chosen descriptor

distance_offset= (ka(1:4,m)-kb(1:4,m)).^2;  % Finding offset

distance_offset=sqrt(distance_offset);

distance_offset=sum(distance_offset)




tolerance=35;   %%% Setting tolerance

% Computing other offset to find consesnus

 for i=1:size(M_ubc,2)
    
    d_offset=(ka(1:4,i)-kb(1:4,i)).^2;
    
    d_offset(i)=sum(sqrt(d_offset));
    
    
    trans(i)= abs(distance_offset-d_offset(i));
    
    
 end
   
 
 
 index_offset=find(trans>tolerance);  % Finding index for consesnus set
 
 consensus_set=length(index_offset);
 
 consesnus_percentage=((consensus_set)/(size(M_ubc,2)))*(100); % Consesnus percentage
 
 
 D=[index_offset];
 
 
%%% Computing best plot%%%%%
 
imageadjoin(:,1:640) = I;
imageadjoin(:,641:1280) =Ib;

figure(4)
imshow(imageadjoin);

hold on
 
for i=1:(consensus_set)
    
ka=F_out(:,M_ubc(1,D(i)));    

kb=F_outb(:,M_ubc(2,D(i)));

plot([ka(1,1),(kb(1,1)+640)],[ka(2,1),kb(2,1)]);

 end

hold off




 
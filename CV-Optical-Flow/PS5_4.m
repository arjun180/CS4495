

clear all

% Question 4. Hierarchial optic flow

% Shift R10,R20,R40 and data sequence 1 and data sequence 2 have been tried
% onto this.

% use level 3 for data sequence 1 and level 5 for data sequence 2

% window size and sigma have been mentioned in the report





L=im2double(((imread('Shift0.png'))));

R=im2double(((imread('ShiftR40.png'))));


g=[0.05 0.25 0.4 0.25 0.05];

w=g.'*g;



n_max=7;         

k=n_max;




for K=k:-1:1

    

    

Lk=reduce_func_LK(L,K);

Rk=reduce_func_LK(R,K);


    

if (K==n_max)
    
 U_1=zeros(size(Lk));
 
 V_1=zeros(size(Lk));


else
    
    
    
    
 if(size(Lk,1)~=(Ut(1,1))||size(Lk,2)~=Ut(1,2))
    
    
 Lk=imresize(Lk,(Ut),'nearest');
 
 Rk=imresize(Rk,(Ut),'nearest');

    
 end


%E1=expand_func_LK(U,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



I1_expand=zeros(2*size(U,1),2*size(U,2));


for i=1:2:size(I1_expand,1)

for j=1:2:size(I1_expand,2)
    

    
    I1_expand([i i+1],[j j+1])=U(((i-1)/2)+1,((j-1)/2)+1);


end



end


E1=(imfilter(I1_expand,w));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



  
%E2=expand_func_LK(V,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

I2_expand=zeros(2*size(V,1),2*size(V,2));


for i=1:2:size(I2_expand,1)

for j=1:2:size(I2_expand,2)
    

    
    I2_expand([i i+1],[j j+1])=V(((i-1)/2)+1,((j-1)/2)+1);


end



end


E2=(imfilter(I2_expand,w));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


E1(isnan(E1))=0;

E2(isnan(E2))=0;
 


 
U_1=2*E1;
   

V_1=2*E2;







end





%%%%%%%%%%%%%%%%%%%%%% Warping image 2 back to
%%%%%%%%%%%%%%%%%%%%%% image%%%%%%%%%%%%%%%%%%%%%%%%




 
[M N]=size(Lk);

[x y]=meshgrid(1:N,1:M);


warpi3=interp2(x,y,Lk,x+U_1,y+V_1,'*nearest');

warpi2=interp2(x,y,Lk,x+U_1,y+V_1,'*linear');

M=find(isnan(warpi2));
 
warpi2(M)=warpi3(M);
 
Wk=warpi2;








%%% Use Lucas Kanade on this implementatiom%%%%%%


  img1 = imfilter(Wk, fspecial('gaussian', 21,4));
  img2 = imfilter(Rk, fspecial('gaussian', 21,4));

% img1=Wk;
%  
% img2=Rk;



Ix = imfilter(img1, [-1 1]);
Iy = imfilter(img1, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = Rk-Wk ;
Ixt = Ix .* It;
Iyt = Iy .* It;


wsize=21; wsig =1.5;


wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));







Dx=zeros(size(img1,1),size(img1,2));

Dy=zeros(size(img1,1),size(img1,2));


for i=1:size(img1,1)
     
for j=1:size(img1,2)



A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        

B=[-wIxt(i,j); -wIyt(i,j)];  
        
        
 X= A\B;    
     
 


Dx(i,j)=X(1,1);
 
Dy(i,j)=X(2,1);



end

end

 
Unew=U_1+Dx;
 
Vnew=V_1+Dy;



U=Unew;

V=Vnew;


 Ut=2*size(U);

 Vt=2*size(V);









end





figure,

imagesc(Unew)

colormap jet

colorbar('east');


figure,

imagesc(Vnew)

colormap jet

colorbar('east');


im1=Rk;

warp_image=warp(im1,Unew,Vnew);

a=Lk-warp_image;

figure,

imshow(a);




 
 








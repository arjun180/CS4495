
%Question 1 Problem set5 
%Question 1.1 and 1.2 require the same bit of code.  

clear all;

I1 = im2double(imread('Shift0.png'));
I2 = im2double(imread('ShiftR40.png'));

I1 = imfilter(I1, fspecial('gaussian', 21,4));
I2 = imfilter(I2, fspecial('gaussian', 21,4));

Ix = imfilter(I1, [-1 1]);
Iy = imfilter(I1, [-1 1]');

Ix2 = Ix .^ 2;
Iy2 = Iy .^ 2;
Ixy = Ix .* Iy;
It  = I2 - I1;
Ixt = Ix .* It;
Iyt = Iy .* It;

wsize = 11;  wsig = 4;

wIx2 = imfilter(Ix2, fspecial('gaussian', wsize, wsig));
wIy2 = imfilter(Iy2, fspecial('gaussian', wsize, wsig));
wIxy = imfilter(Ixy, fspecial('gaussian', wsize, wsig));
wIxt = imfilter(Ixt, fspecial('gaussian', wsize, wsig));
wIyt = imfilter(Iyt, fspecial('gaussian', wsize, wsig));




for i=1:size(I1,1)
    
    for j=1:size(I1,2)
        
        
        A=[wIx2(i,j) wIxy(i,j); wIxy(i,j) wIy2(i,j)];
        
        B=[-wIxt(i,j); -wIyt(i,j)];  
        
        
     X= A\B;
     
     U(i,j)=X(1,1);
     
     V(i,j)=X(2,1);
        
        

    
    
    
    
 end
end




figure,
imagesc(U);

colormap jet

colorbar('east');


figure,

imagesc(V);

colormap jet

colorbar('east');

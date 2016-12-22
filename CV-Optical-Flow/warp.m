function [ warpi2 ] = warp(im2,U,V )

[M N]=size(im2);

[x,y]=meshgrid(1:N,1:M);

warpi3=interp2(x,y,im2,x+U,y+V,'*nearest');

warpi2=interp2(x,y,im2,x+U,y+V,'*linear');

M=find(isnan(warpi2));
 
warpi2(M)=warpi3(M);
 

end


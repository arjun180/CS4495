function[k]= reduce_func_LK(I,n)

if(n==1)
    
g=[0.05 0.25 0.4 0.25 0.05];

w=g.'*g;
    


I1=imfilter(I,w);

I1=I1(1:2:end,1:2:end);

k=I1;

else 
    
for i=1:n
     
g=[0.05 0.25 0.4 0.25 0.05];

w=g.'*g;
    

I1=imfilter(I,w);  
 
k=I1(1:2:end,1:2:end);  

I=k;


   end
 
end

end


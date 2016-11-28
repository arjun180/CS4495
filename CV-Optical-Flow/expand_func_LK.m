function[T]= expand_func_LK(I1,n)


g=[0.05 0.25 0.4 0.25 0.05];

w=g.'*g;




for i=1:n


I1_expand=zeros(2*size(I1,1),2*size(I1,2));




for i=1:2:size(I1_expand,1)

for j=1:2:size(I1_expand,2)
    

    
    I1_expand([i i+1],[j j+1])=I1(((i-1)/2)+1,((j-1)/2)+1);


end



end


I1_expand=(imfilter(I1_expand,w));

T=I1_expand;  

I1=I1_expand;





end
end




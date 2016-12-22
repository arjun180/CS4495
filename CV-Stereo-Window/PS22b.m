
%Problem Set 2 Question 2
%Left to Right

ImgLeft=im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-L.png')));
ImgRight= im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-R.png')));

ImgLeft=imresize(ImgLeft,[256 256]);
ImgRight=imresize(ImgRight,[256 256]);

% figure,imshow(ImgLeft);

[rows cols]= size(ImgLeft);
[tplrows tplcols]= size(ImgRight);
% s=zeros(128,128);
% row_min=ones(128,1);

disp=zeros(256,256);
ssdnew=zeros(256,256);



% best_ssd=0;


win=5;

 for m=1:256-win+1
    
    for n=1:256-win+1
        
        for k = 1:256-win+1
                      
            for i=1:win-1
                for j=1:win-1
            
                     sum1(i,j)=(ImgRight(i+m,j+n)- ImgLeft(i+m,j+k)).^2;
            
                end
            end
           
            
       ssd(k)=sum(sum(sum1));
           
     end      
        ssdnew(m,n)=min(find(ssd==min(ssd(:))));
    
    end
    
    end
     
        

 
  for m=1:254
        for n= 1:254
           
           disp(m,n)=ssdnew(m,n)-n;
       end
  end
   
   figure(1)
   imshow(disp,[-100 140]);
   
    figure(2)
   surf((double(disp)),'FaceColor','interp','EdgeColor','none','FaceLighting','phong')

      
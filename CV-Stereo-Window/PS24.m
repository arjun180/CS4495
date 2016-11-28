
%problem set 2 Question 4
%Normalized correlation

ImgLeft=im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-L.png')));
ImgRight= im2double(rgb2gray(imread('http://www.cc.gatech.edu/~afb/classes/CS4495-Fall2014/ProblemSets/PS2/Data/proj2-pair1-R.png')));

ImgLeft=imresize(ImgLeft,[256 256]);
ImgRight=imresize(ImgRight,[256 256]);


[rows cols]= size(ImgLeft);
[tplrows tplcols]= size(ImgRight);


templatesize=7;

template=rand(templatesize);

X=round((tplrows-templatesize-1)+1);
Y=round((tplcols-templatesize-1)+1);


ImgRight(X:X+templatesize-1,Y:Y+templatesize-1)=template;

ncc=normxcorr2(template,ImgRight);

   
nccnew(Y:Y+templatesize-1)= max(max(ncc));


ncc1(X:X+templatesize-1,Y:Y+templatesize-1)= max(find(nccnew==max(nccnew(:))));

disp(X:X+templatesize-1,Y:Y+templatesize-1)=nccnew(X:X+templatesize-1,Y:Y+templatesize-1)-(Y:Y+templatesize-1);
        

figure,imshow(disp,[-180 30]);
    
      
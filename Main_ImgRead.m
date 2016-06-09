function Main_ImgRead

[s,~] = listdlg('PromptString','Select the Character Recognition set:','SelectionMode','single','ListString',{'A-Z','a-z','0-9','ALL'});

if s==1
    num=11:1:36;
    digits = [];
    labels = zeros(55*26,26);
elseif s==2
    num=37:1:62;
    digits = [];
    labels = zeros(55*26,26);
elseif s==3
    num=1:1:10;
    digits = [];
    labels = zeros(55*10,10); 
elseif s==4
    num=1:1:62;
    digits = [];
    labels = zeros(55*62,62); 
end

% num=62;
% digits = [];
% labels = zeros(55*62,62);

delete('digits.mat','labels.mat');
basepath = pwd;
cd(strcat(basepath,'\English\Hnd\Img'));
fd = pwd;
% Reading folders:
for k=1:1:length(num)
    num(k)
    if num(k)<10
        folder = strcat(fd,'\Sample00',num2str(num(k)),'\');
    else
        folder = strcat(fd,'\Sample0',num2str(num(k)),'\');
    end
    cd(folder);
    imgList = dir('*.png');
    imgNos = length(imgList);
    matx = zeros(55,108);
    % Reading all images:
    for j=1:imgNos
        filename = imgList(j).name;
        OrigI{k}{j} = imresize(crop_edge(imread(filename)),[50,50]);
        % 1. Grayscale of image:
        OrigBWI{k}{j} = rgb2gray(OrigI{k}{j});
        %         temp = double(OrigBWI{i}{j});
        %         temp(temp>128) = 0; temp(temp<=128) = 1;
        % 2. Binary of image:
        OrigBinI{k}{j} = im2bw(OrigBWI{k}{j});
        % 3. Skeleton of image:
        
        Ifill = imfill(OrigBinI{k}{j},'holes');
        Ifill = Ifill & OrigBWI{k}{j};
        re = imcomplement(Ifill);        
        [fl, ~]=lines(re);
        [L, ~] = bwlabel(fl);
        n=1;[r,c] = find(L==n);
        n1 = fl(min(r):max(r),min(c):max(c));
        OrigMorphI{k}{j} = imcomplement(bwmorph((n1),'thin',1));
        z = OrigMorphI{k}{j};
        matx(j,:) = feature_extract(z);
        labels(j+(k-1)*55,k) = 1;
    end
    digits = [digits; matx];
end
% [features]=feature_extract(image);
% training(features,0);
cd(basepath);
training(digits',labels');
save digits.mat digits
save labels.mat labels
save option.mat s

end




function [features]=feature_extract(image)

original_image=image;% just backing up the orginal image
row=size(image,1);
column=size(image,2);
% we have to ceil this no.s to the nearest multiple of 3 since
% 3x3 windowing is used

% first we have to ensure that image consists of minimum 9 rows and minimum
% 9 columns
add_rows=0; %no of additional rows to make min of 9x9 matrix
add_columns=0; % similar for columns
if row<9
    add_rows=9-row;
end
if column<9
    add_columns=9-column;
end

if mod(add_rows,2)==0
    image=[zeros(add_rows/2,column);image;zeros(add_rows/2,column)];
else
    image=[zeros((add_rows-1)/2,column);image;zeros((add_rows+1)/2,column)];
end
%appending rows of zeros
%after above op, no.of rows changes so it should be updated
%equal no of rows should be added on top and bottom
row=size(image,1);
if mod(add_columns,2)==0
    image=[zeros(row,(add_columns)/2),image,zeros(row,(add_columns)/2)];
else
    image=[zeros(row,(add_columns-1)/2),image,zeros(row,(add_columns+1)/2)];
end
column=size(image,2); %updating the column value


n_rows=ceil(row/3)*3-row; % no of rows of zeros to be added
n_columns=ceil(column/3)*3-column; % no of columns of zeros to be added
% assume row=4, so 2 rows of zeros should be added. ceil(4/3)*3 will return
% 6 which is nearest multiple of 3 to 4 from right side. So n_rows will
% contain no.of rows to be added to the image.

if mod(n_rows,2)==0
    image=[zeros(n_rows/2,column);image;zeros(n_rows/2,column)];
else
    image=[zeros((n_rows-1)/2,column);image;zeros((n_rows+1)/2,column)];
end
%appending rows of zeros
%after above op, no.of rows changes so it should be updated
%equal no of rows should be added on top and bottom
row=size(image,1);
if mod(n_columns,2)==0
    image=[zeros(row,(n_columns)/2),image,zeros(row,(n_columns)/2)];
else
    image=[zeros(row,(n_columns-1)/2),image,zeros(row,(n_columns+1)/2)];
end
column=size(image,2); %updating the column value
% so now the image can be divided into 3x3 zones
% here in above code some more features are to be added, like if two rows
% of zeros are to be added then one on either side of the image and
% similarily for columns.

zone_height=row/3;
zone_width=column/3;
%say at this point image is 12x9, so no.of rows in each zone should be
%12/3=4, whereas columns should be 9/3=3. This is stored in variables zone
%height and width
zone11=image(1:zone_height,1:zone_width);
zone12=image(1:zone_height,(zone_width+1):2*zone_width);
zone13=image(1:zone_height,(2*zone_width+1):end);

zone21=image((zone_height+1):2*zone_height,1:zone_width);
zone22=image((zone_height+1):2*zone_height,(zone_width+1):2*zone_width);
zone23=image((zone_height+1):2*zone_height,(2*zone_width+1):end);

zone31=image((2*zone_height+1):end,1:zone_width);
zone32=image((2*zone_height+1):end,(zone_width+1):2*zone_width);
zone33=image((2*zone_height+1):end,(2*zone_width+1):end);

% feature_vectors
zone11_features=line_classifier(zone11);
zone12_features=line_classifier(zone12);
zone13_features=line_classifier(zone13);

zone21_features=line_classifier(zone21);
zone22_features=line_classifier(zone22);
zone23_features=line_classifier(zone23);

zone31_features=line_classifier(zone31);
zone32_features=line_classifier(zone32);
zone33_features=line_classifier(zone33);

euler=bweuler(image);


features=[zone11_features;zone12_features;zone13_features;zone21_features;zone22_features;zone23_features;zone31_features;zone32_features;zone33_features];
end



function img_2 = crop_edge(img_1)
y = sum(~img_1,1); % Sum over columns
x = sum(~img_1,2); % Sum over rows
lr = find(y~=0); % Left,Right
ud = find(x~=0); % Up,Down
img_2 = imcrop(img_1,[lr(1), ud(1), lr(end)-lr(1) ud(end)-ud(1)]);
end


function [featurevector]=line_classifier(image)

row=size(image,1);
column=size(image,2);

[Gmag, Gdir]=imgradient(image);
code0=0;
code1=0;
code2=0;
code3=0;
code3=0;
code4=0;
code5=0;
code6=0;
code7=0;
code8=0;
code9=0;
code10=0;
code11=0;

for r = 1:row
    for c = 1:column
        if Gdir(r,c) >= 0 && Gdir(r,c) < 30
            Code(r,c) = 0;
            code0=code0+1;
        elseif Gdir(r,c) >= 30 && Gdir(r,c) < 60
            Code(r,c) = 1;
            code1=code1+1;
        elseif Gdir(r,c) >= 60 && Gdir(r,c) < 90
            Code(r,c) = 2;
            code2=code2+1;
        elseif Gdir(r,c) >= 90 && Gdir(r,c) < 120
            Code(r,c) = 3;
            code3=code3+1;
        elseif Gdir(r,c) >= 120 && Gdir(r,c) < 150
            Code(r,c) = 4;
            code4=code4+1;
        elseif Gdir(r,c) >= 150 && Gdir(r,c) <180
            Code(r,c) = 5;
            code5=code5+1;
        elseif Gdir(r,c) >= -180 && Gdir(r,c) < -150
            Code(r,c) = 6;
            code6=code6+1;
        elseif Gdir(r,c) >= -150 && Gdir(r,c) < -120
            Code(r,c) = 7;
            code7=code7+1;
        elseif Gdir(r,c) >= -120 && Gdir(r,c) < -90
            Code(r,c) = 8;
            code8=code8+1;
        elseif Gdir(r,c) >= -90 && Gdir(r,c) < -60
            Code(r,c) = 9;
            code9=code9+1;
        elseif Gdir(r,c) >= -60 && Gdir(r,c) < -30
            Code(r,c) = 10;
            code10=code10+1;
        elseif Gdir(r,c) >= -30 && Gdir(r,c) < 0
            Code(r,c) = 11;
            code11=code11+1;
        end
    end
end

featurevector=[code0;code1;code2;code3;code4;code5;code6;code7;code8;code9;code10;code11];
end




function [fl, re]=lines(im_texto)
% Divide text in lines
% im_texto->input image; fl->first line; re->remain line
% Example:
% im_texto=imread('TEST_3.jpg');
% [fl re]=lines(im_texto);
% subplot(3,1,1);imshow(im_texto);title('INPUT IMAGE')
% subplot(3,1,2);imshow(fl);title('FIRST LINE')
% subplot(3,1,3);imshow(re);title('REMAIN LINES')
im_texto=clip(im_texto);
num_filas=size(im_texto,1);
for s=1:num_filas
    if sum(im_texto(s,:))==0
        nm=im_texto(1:s-1, :); % First line matrix
        rm=im_texto(s:end, :);% Remain line matrix
        fl = clip(nm);
        re=clip(rm);
        %*-*-*Uncomment lines below to see the result*-*-*-*-
        %         subplot(2,1,1);imshow(fl);
        %         subplot(2,1,2);imshow(re);
        break
    else
        fl=im_texto;%Only one line.
        re=[];
    end
end
end

function img_out=clip(img_in)
[f c]=find(img_in);
img_out=img_in(min(f):max(f),min(c):max(c));%Crops image
end
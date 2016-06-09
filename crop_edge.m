function img_2 = crop_edge(img_1)
y = sum(~img_1,1); % Sum over columns
x = sum(~img_1,2); % Sum over rows
lr = find(y~=0); % Left,Right
ud = find(x~=0); % Up,Down
img_2 = imcrop(img_1,[lr(1), ud(1), lr(end)-lr(1) ud(end)-ud(1)]);
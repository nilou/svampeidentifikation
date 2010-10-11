RGB = im2double(imread('test8.JPG'));
small = RGB(1:8:size(RGB,1),1:8:size(RGB,2),:);
%level = graythresh(small);
%bw = im2bw(small,level);
%imshow(bw)

edges = [];
edges(:,:,1) = edge(small(:,:,1), 'sobel');
edges(:,:,2) = edge(small(:,:,2), 'sobel');
edges(:,:,3) = edge(small(:,:,3), 'sobel');
edgesAll = edges(:,:,1) + edges(:,:,2) + edges(:,:,3);
%figure(1)
%imshow(edgesAll)
edgesAll = bwareaopen(edgesAll, 10);
%figure(2)
%imshow(bw)
n = size(find(edgesAll==1),1);
xs = zeros(n,1);
ys = zeros(n,1);
i = 1;
for x=(1:1:size(edgesAll,1))
    for y=(1:1:size(edgesAll,2))
        if edgesAll(x,y)==1
            xs(i) = x;
            ys(i) = y;
            i = i +1;
        end
    end
end
hull = convhull(xs,ys,{'Qt'});
points = [xs ys]';
xs = xs(hull);
ys = ys(hull);
mask = poly2mask(ys,xs,size(edgesAll,1),size(edgesAll,2));
figure(1)
imshow(edgesAll)
small(not(cat(3,mask,mask,mask))) = NaN;


figure(2)
imshow(small)

mu = mean(points,2);
covariance = cov(points);
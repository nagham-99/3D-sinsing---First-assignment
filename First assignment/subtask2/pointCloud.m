%Load the stereo parameters.
load('calibrationSession.mat');
showExtrinsics(stereoParams);
 
%Read in the stereo pair of images.
I1 = imread('scene_right.jpg');
I2 = imread('scene_left.jpg');
 
%Rectify the images then display the images after rectification.
[J1, J2] = rectifyStereoImages(I1,I2,stereoParams);
figure 
imshow(cat(3,J1(:,:,1),J2(:,:,2:3)),'InitialMagnification',200);
 
%Compute the disparity
disparityMap = disparitySGM(rgb2gray(J1),rgb2gray(J2));
figure 
imshow(disparityMap,[0,64],'InitialMagnification',200);
 
%Reconstruct the 3-D world coordinates of points corresponding to each pixel from the disparity map
xyzPoints = reconstructScene(disparityMap,stereoParams);
 
Z = xyzPoints(:,:,3);
mask = repmat(Z > 3200 & Z < 6700,[1,1,3]);
J1(~mask) = 0;
imshow(J1,'InitialMagnification',200);

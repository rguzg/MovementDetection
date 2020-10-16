shuttleVideo = VideoReader('TheTatamiGalaxy-ED01-NCBD.avi');

ii = 1;

while hasFrame(shuttleVideo)
   img = readFrame(shuttleVideo);
   filename = [sprintf('%03d',ii) '.jpg'];
   fullname = fullfile('D:\raulg\Desktop\Stuff\Frames',filename);
   imwrite(img,fullname)    % Write out to a JPEG file (img1.jpg, img2.jpg, etc.)
   ii = ii+1;
end
% Movement Detection
% Detect movement on a set of images using image subtraction

% Parameters:
% folder -> Folder where the images to analyze are located. All images must
% be JPEGs and also the same size
% outputFolder -> Folder where the analyzed images will be saved
% k -> Number of images to analyze before the OR operation is performed
% theta -> Umbralization percentage (in decimals)
% video -> If this value is true the analyzed images will also be saved as a video

function MovementDetection(folder, k, theta, outputFolder, video)
    if ~endsWith(folder, '\')
        imagePath = strcat(folder,'\*.jpg');
        folder = strcat(folder,'\');
    else
        imagePath = strcat(folder,'*.jpg');
    end
    
    if ~endsWith(outputFolder, '\')
        outputFolder = strcat(outputFolder,'\');
    end
    
    if video
        fprintf('Output will also be saved as %svideo.avi\n', outputFolder);
        outputVideo = MovementVideo(strcat(outputFolder, 'video.avi'));
    end
    
    fprintf('Using %s as the source folder\n', folder);
    fprintf('Using %s as the output folder\n', outputFolder);
    
    imageCollection = dir(imagePath);
    queue = ImageQueue(k);

    for n=1 : length(imageCollection)
        if(imageCollection(n).isdir == 0)
            
            fprintf('Image # %s\n', int2str(n));
            
            currentImage = imread(sprintf('%s%s', folder, imageCollection(n).name));
            imageSize = size(currentImage);
           
            % When reading the first image there's no previous image so we use
            % a placeholder
            if(n == 1)
                previousImage = zeros(imageSize);
            else
                previousImage = imread(sprintf('%s%s', folder, imageCollection(n-1).name));
            end
            
            [subtractedImage, maximumDifference] = RestaImagenes(currentImage, previousImage);
            umbralizedImage = umbralizarByN(subtractedImage, maximumDifference * theta, 1);
            
            queue.add(umbralizedImage);
            
            if(queue.full)
                resultImage = MultipleOR(queue);
                highlight = HighlightImage(resultImage, currentImage);
                imwrite(highlight, strcat(outputFolder, sprintf('movement%s.jpg', int2str(n))));
                fprintf('Wrote movement%s.jpg\n', int2str(n));
                
                if video
                    outputVideo.addFrame(highlight);
                    fprintf('Wrote frame #%s\n', int2str(n));
                end
            else
               if video
                    outputVideo.addFrame(currentImage);
                    fprintf('Wrote frame #%s\n', int2str(n));
                end 
            end
        end
    end
    if video
        outputVideo.endVideo();
    end
end
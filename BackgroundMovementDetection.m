% Background Movement Detection
% Detect movement on a set of images using its background

% Parameters:
% folder -> Folder where the images to analize are located. All images must
% be JPEGs and also the same size
% outputFolder -> Folder where the analyzed images will be located
% k -> Number of images to analize before the OR operation is performed
% theta -> Umbralization percentage (in decimals)
% video -> If this value is true the analyzed images will also be saved as a video

function BackgroundMovementDetection(folder, k, theta, outputFolder, video)
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
    imageSize = size(imread(sprintf('%s%s', folder, imageCollection(1).name)));
    % Convert to double to prevent overflow/underflow errors
    backgroundImage = double(zeros(imageSize));
    
    % Get the background image by getting the average of all of the input
    % photos
    for n=1 : length(imageCollection)
        fprintf('Getting average. Using Image# %s\n', int2str(n));
        currentImage = imread(sprintf('%s%s', folder, imageCollection(n).name));
        backgroundImage = backgroundImage + double(currentImage);
    end

    backgroundImage = uint8(backgroundImage/length(imageCollection));
    imwrite(backgroundImage, strcat(outputFolder, 'average%s.jpg'));
    
    fprintf('Average calculation finished\n');
    fprintf('Average image saved as [outputFolder]\average.jpg\n');
    
    for n=1 : length(imageCollection)
        if(imageCollection(n).isdir == 0)
            
            fprintf('Detecting movement. Using Image # %s\n', int2str(n));
            
            currentImage = imread(sprintf('%s%s', folder, imageCollection(n).name));         
            
            %[subtractedImage, maximumDifference] = RestaImagenes(backgroundImage, currentImage);
            [subtractedImage, maximumDifference] = RestaImagenes(currentImage, backgroundImage);
            umbralizedImage = umbralizarByN(subtractedImage, maximumDifference * theta, 1);  
            
            highlight = HighlightImage(umbralizedImage, currentImage);
            
            if mod(n,k) == 0
                imwrite(highlight, strcat(outputFolder, sprintf('movement%s.jpg', int2str(n))));
                fprintf('Wrote movement%s.jpg\n', int2str(n));
            end
            
            if video
                    outputVideo.addFrame(highlight);
                    fprintf('Wrote frame #%s\n', int2str(n));
            end
        end
    end
    if video
        outputVideo.endVideo();
    end
end
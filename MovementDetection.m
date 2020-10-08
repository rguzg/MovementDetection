% Movement Detection
% Detect movement on a set of images using image substraction

% Parameters:
% folder -> Folder where the images to analize are located. All images must
% be the same size
% k -> Number of images before OR operation is performed
% theta -> Umbralization percentage (in decimals)

function MovementDetection(folder, k, theta)
    if ~endsWith(folder, '\')
        imagePath = strcat(folder,'\*.jpg');
        folder = strcat(folder,'\');
    else
        imagePath = strcat(folder,'*.jpg');
    end

    fprintf('Using %s as the source folder\n', folder);
    
    imageCollection = dir(imagePath);

    for n=1 : length(imageCollection)
        if(imageCollection(n).isdir == 0)
            fprintf('Image # %s\n', int2str(n));
            
            originalImage = imread(sprintf('%s%s', folder, imageCollection(n).name));
            imageSize = size(originalImage);
           
            % When reading the first image there's no previous image so we use
            % a placeholder
            if(n == 1)
                previousImage = zeros(imageSize);
            else
                previousImage = imread(sprintf('%s%s', folder, imageCollection(n-1).name));
            end
        end
    end
end
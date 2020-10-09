% This is a helper function that highlights the movement detected by
% MovementDetection

% Parameters:
% movement -> Image produced by MultipleOR
% currentImage -> Image that will be highlighted

% Returns:
% highlightedImage -> Highlighted image

function highlightedImage = HighlightImage(movement, currentImage)
    for i = 1 : size(movement,1)
        for j = 1 : size(movement,2)
            % If movement was detected the pixel color in this position
            % will be greater than zero
            if(movement(i,j) > 0)
                % The image is highlighted in blue
                currentImage(i,j,1:2) = 0;
                currentImage(i,j,3) = 255;
            end
        end
    end
    highlightedImage = uint8(currentImage);
end

% This function recieves an image queue and performs an OR operation to all
% of the elements in it

% Parameters:
% fullQueue -> full ImageQueue object

% Returns:
% resultImage -> Result of performing an OR operation on all of the
% elements in the queue

function resultImage = MultipleOR(fullQueue)
% Get the first item in the queue, all future operations will be made 
% using this variable    
resultImage = fullQueue.get();

 for i = (fullQueue.index) : 4
     % max() is equivalent to doing a bitwise or over the two images
     resultImage = max(resultImage, fullQueue.get());
 end
 
 resultImage = uint8(resultImage);
end
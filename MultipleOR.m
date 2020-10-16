% This function recieves an image queue and performs an OR operation to all
% of the elements in it

% Parameters:
% queue -> full ImageQueue object

% Returns:
% resultImage -> Result of performing an OR operation on all of the
% elements in the queue

function resultImage = MultipleOR(queue)
% Get the first item in the queue, all future operations will be made 
% using this variable    
resultImage = queue.get();

 for i = (queue.index) : queue.size
     % max() is equivalent to doing a bitwise or over the two images
     resultImage = max(resultImage, queue.get());
 end
 
 resultImage = uint8(resultImage);
end

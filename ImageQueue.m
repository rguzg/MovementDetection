classdef ImageQueue < handle
    properties
        % Maximum number of images to be held in queue
        size
        % Current place in the queue
        index
        % True if index == 1
        full
        % True if index == size
        empty
        % Array that acts as a queue
        array
    end
    methods
        function object = ImageQueue(elements)
            object.size = elements;
            object.index = elements;
            object.full = false;
            object.empty = true;
            object.array;
        end
        function add(object, image)
            if object.full
                throw(MException('ImageQueue:Error','The queue is full'));
            else
                object.empty = false;
                object.array(:,:,object.index) = image;
                
                if object.index == 1
                    object.full = true;
                else
                    object.index = object.index - 1;
                end
            end
        end
        function image = get(object)
            if object.empty
                throw(MException('ImageQueue:Error', 'The queue is empty'));
            else
                object.full = false;
                image = object.array(:,:,object.index);
                object.array(:,:,object.index) = 0;
                
                if(object.index == object.size)
                    object.empty = true;
                else
                    object.index = object.index + 1;
                end
            end
        end
    end
end
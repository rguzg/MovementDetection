classdef MovementVideo < handle
    properties
        % video object
        movie
    end
    methods
        function object = MovementVideo(output)
            object.movie = VideoWriter(output);
            object.movie.FrameRate = 25;
            object.movie.Quality = 80;
            open(object.movie);
        end
        function addFrame(object, frame)
            writeVideo(object.movie, frame);
        end
        function endVideo(object)
            close(object.movie);
            disp('Closed video');
        end
    end
end
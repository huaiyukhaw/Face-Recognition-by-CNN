% Create the face detector object.
faceDetector = vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[150,150]);

% Here the loop runs for 300 times you can change the threshold (n) based on the number of training data you need
n = 300;

% change str to s01,s02,s03,.... for saving  upto how many subjects you want to save for saving in respective folders for 
% imwrite in line 88

str = 's01';

% Create the point tracker object.
pointTracker = vision.PointTracker('MaxBidirectionalError', 2);

% Create the webcam object.
cam = webcam();

% Capture one frame to get its size.
videoFrame = snapshot(cam);
frameSize = size(videoFrame);

% Create the video player object.
videoPlayer = vision.VideoPlayer('Position', [100 100 [frameSize(2), frameSize(1)]+30]);
runLoop = true;
numPts = 0;
frameCount = 0;
i=1;

while runLoop && frameCount < n

    % Get the next frame.
    videoFrame = snapshot(cam);
    videoFrameGray = rgb2gray(videoFrame);
    frameCount = frameCount + 1;

    imwrite(videoFrame,[ 'photos\',str,'\',int2str(i), '.jpg']);

    % Display the annotated video frame using the video player object.
    step(videoPlayer, videoFrame);

    % Check whether the video player window has been closed.
    runLoop = isOpen(videoPlayer);
    
    i = i+1
end

% Clean up.
clear cam;
release(videoPlayer);
release(pointTracker);
release(faceDetector);

import cv2
import os

vidcap = cv2.VideoCapture("D:\\raulg\\Downloads\\IMG_7716.mp4")
success,image = vidcap.read()
count = 0
os.chdir('Frames')

while success:
  cv2.imwrite("frame%d.jpg" % count, image)     # save frame as JPEG file      
  success,image = vidcap.read()
  print('Read a new frame:', count)
  count += 1
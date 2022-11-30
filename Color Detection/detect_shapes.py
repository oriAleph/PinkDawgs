"""
Purpose:        Detects a shape using blurring and threshold functions
"""

#importing
from shapedetector import ShapeDetector
import argparse
import imutils
import cv2

ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True,
    help="path to the input image")
args = vars(ap.parse_args())

#load the image and resize it to a smaller factor so that
#the shapes can be approximated better
image = cv2.imread(args["image"])

cv2.imshow("original_image",image)
cv2.waitKey(0)

resized = imutils.resize(image, width=300)
ratio = image.shape[0] / float(resized.shape[0])

#convert the resized image to greyscale, blur it slightly,
#and threshold it
grey = cv2.cvtColor(resized, cv2.COLOR_BGR2GRAY)
blurred =cv2.GaussianBlur(grey, (5,5), 0)
#median_blurr = cv2.medianBlur(blurred, 5)
#thresh = cv2.threshold(median_blurr, 120, 255, cv2.THRESH_BINARY)[1]
thresh = cv2.threshold(blurred, 80, 255, cv2.THRESH_BINARY)[1]


cv2.imshow("grey",grey)
cv2.waitKey(0)

cv2.imshow("blurred",blurred)
cv2.waitKey(0)

"""cv2.imshow("median_blurr",median_blurr)
cv2.waitKey(0)"""

cv2.imshow("median_thresh",thresh)
cv2.waitKey(0)


#find contours in the thresholded image and initialize the
#shape detector
cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,
    cv2.CHAIN_APPROX_SIMPLE)
cnts = imutils.grab_contours(cnts)
sd = ShapeDetector()

#loop over the contours
for c in cnts:
    #compute the center of the contour, then detect the name of the 
    #shape using only the contour
    M = cv2.moments(c)
    cX = int((M["m10"] / M["m00"]) * ratio)
    cY = int((M["m01"] / M["m00"]) * ratio)
    shape = sd.detect(c)

    #multiply the contour (x, y) coordinates by the resize ratio,
    #then draw the contours and the name of the shape on the image
    c = c.astype("float")
    c *=ratio
    c = c.astype("int")
    cv2.drawContours(image, [c], -1, (0,255,0), 2)
    cv2.putText(image, shape, (cX,cY), cv2.FONT_HERSHEY_SIMPLEX,
        0.5, (0,0,0), 2)

cv2.imshow("Image",image)
cv2.waitKey(0)
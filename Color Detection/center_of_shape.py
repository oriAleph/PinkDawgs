"""
Purpose:        Calculates the center of a shape if the shape is able to be identified
"""

#import the necessary packages
import argparse
import imutils
import cv2

#construct the argument parse and parse the arguments
ap = argparse.ArgumentParser()
ap.add_argument("-i", "--image", required=True,
    help="path to the input image")
args = vars(ap.parse_args())

#load the image, convert it to greyscale, blur it slightly
#and threshold it
image = cv2.imread(args["image"])

print("image shape: height: ", image.shape[0], ",","width: ", image.shape[1])

#image_down = cv2.resize(image,(300,200), interpolation = cv2.INTER_LINEAR)
grey = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
blurred =cv2.GaussianBlur(grey, (5,5), 0)
median_blurr = cv2.medianBlur(blurred, 5)
#thresh = cv2.threshold(blurred, 60, 255, cv2.THRESH_BINARY)[1]
thresh = cv2.threshold(median_blurr, 60, 255, cv2.THRESH_BINARY)[1]

"""cv2.imshow("image", image)
cv2.waitKey(0)

cv2.imshow("image", grey)
cv2.waitKey(0)

cv2.imshow("image", blurred)
cv2.waitKey(0)

cv2.imshow("image", thresh)
cv2.waitKey(0)

"""

#find contours in the threholded image
cnts = cv2.findContours(thresh.copy(), cv2.RETR_EXTERNAL,
    cv2.CHAIN_APPROX_SIMPLE)
cnts = imutils.grab_contours(cnts)

print("cnts: ", cnts)

i = 0
#loop over the contours
for c in cnts:
    #compute the cneter of the contour
    M = cv2.moments(c)

    if M["m00"] == 0:
        cX = 0
        cY = 0
    else:
        cX = int(M["m10"] / M["m00"])
        cY = int(M["m01"] / M["m00"])

    #draw the contour and center of the shape on the image
    cv2.drawContours(image, [c], -1, (0,255,0), 2)
    cv2.circle(image, (cX,cY), 7, (255,255,255), -1)
    cv2.putText(image, "center", (cX -20, cY - 20),
        cv2.FONT_HERSHEY_SIMPLEX, 0.5, (0,0,0), 2)

cv2.imshow("image", image)
cv2.waitKey(0)
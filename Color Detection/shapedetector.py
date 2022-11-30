"""
Purpose:        Class for defining the possible shapes being detected
"""

#import the necessary packages
import cv2

class ShapeDetector:
    def __init__(self):
        pass

    def detect(self, c): #method with c as the only argument
        #initiallize the shape name and approximate the contour
        shape = "unidentified"
        peri = cv2.arcLength(c, True) #compute the perimeter of the contour
        approx = cv2.approxPolyDP(c, 0.04 * peri, True) # contour approximation
            #common values for second parameter 1% - 5%

        #if the shape is a triangle, it will have 3 vertices
        if len (approx) == 3:
            shape = "triangle"

        #if the shape has 4 vertices, it is either a square or
        #a rectangle
        elif len(approx) == 4:
            #compute the bounding box of the contour and use the
            #bounding box to compute the aspect ration
            (x,y,w,h) = cv2.boundingRect(approx)
            ar = w / float(h)

            #a square will have an aspect ratio that is approximately
            #equal to one otherise, the shape is a rectangle
            shape = "sqaure" if ar >= 0.95 and ar <= 1.05 else "rectangle"

        #if the shape is a pentagon, it will have 5 vertices
        elif len(approx) == 5:
            shape = "pentagon"

        #otherwise, we assume the shape is a circle
        else:
            shape = "circle"

        return shape

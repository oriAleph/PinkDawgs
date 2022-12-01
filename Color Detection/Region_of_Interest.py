"""
Purpose:        Module measures image and draws lines on image to be able to hard code
                    the size of the region of interest
"""

import cv2

orig_image = cv2.imread("./sample_lego_pics/black_lego.jpg")

#image size 3024 x 4032

def MapImage (image):

    print("X - size: ", orig_image.shape[1], "Y - Size: ", orig_image.shape[0])

    #new_image = cv2.line(orig_image, (0,1000), (orig_image.shape[0], 1000), (255,255,255), 5)

    y_axis = int(orig_image.shape[0] / 500)

    print("y-axis: ", y_axis)

    new_image = orig_image

    for y in range(y_axis):
        print("for loop y: ", y)
        start_point = (0, 500 * y)
        end_point = (orig_image.shape[1], 500 * y)

        print("start point: ", start_point, "end_point: ", end_point)
        new_image = cv2.line(new_image, start_point, end_point, (255,255,255), 5)
    """    new_image = cv2.putText(new_image, 'Line: ' + str(y), (int(orig_image.shape[1] / 2), y * 1000),
            cv2.FONT_HERSHEY_SIMPLEX, 10, (209, 31, 200), 15, cv2.LINE_AA )"""

    x_axis = int(orig_image.shape[1] / 200)

    for x in range(x_axis):
        print("for loop y: ", x)
        start_point = (x * 200, 0)
        end_point = (x * 200, orig_image.shape[0])

        print("start point: ", start_point, "end_point: ", end_point)
        new_image = cv2.line(new_image, start_point, end_point, (255,255,255), 5)
    """    new_image = cv2.putText(new_image, 'Line: ' + str(y), (int(orig_image.shape[1] / 2), y * 1000),
            cv2.FONT_HERSHEY_SIMPLEX, 10, (209, 31, 200), 15, cv2.LINE_AA )"""

    return new_image

def ShowLines(image):
    cv2.namedWindow("Y - Lines", cv2.WINDOW_NORMAL)

    cv2.resizeWindow("Y - Lines", 600, 800)

    cv2.imshow('Y - Lines', image)
    cv2.waitKey(0)

    #Region is hard coded for now until we can detect the object
    ROI_Image = orig_image[1000: 2500, 400:2400]

    y = int((2500 - 1000) / 2)
    x = int((2400 - 400) / 2)

    center = y,x

    #This area will be blurred and threholded then will call to identify the color
    ROI_Image = cv2.circle(ROI_Image, (x,y), 20, (255,255,255), 5)

    cv2.namedWindow("ROI_Image", cv2.WINDOW_NORMAL)
    cv2.resizeWindow("ROI_Image", 800, 600)
    cv2.imshow("ROI_Image", ROI_Image)

    cv2.waitKey(0)

    cv2.destroyAllWindows()
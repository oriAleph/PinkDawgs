"""
Purpose:        Takes a singular picture and identifies the hex value of the specified area
"""

import cv2

def bgr_to_hex(bgr = []):

    red = "0x{:02x}".format(bgr[2])    
    green = "0x{:02x}".format(bgr[1])
    blue = "0x{:02x}".format(bgr[0])

    


    print("hex colors")
    print("red: ", red)
    print("green: ", green)
    print("blue: ", blue)

    color_hex = ""
    color_hex += red
    color_hex += green[2:]
    color_hex += blue[2:]

    return color_hex 
    

img = cv2.imread("./sample_lego_pics/grey_corner_lego.png")

#print(img)
#Displays the pixels
#[Blue, Green, Red]

height, width, _= img.shape

center_x = int(width / 2)
center_y = int(height / 2)



pixel_center = img[center_y, center_x]

print(pixel_center)

print("pixel_center: ", pixel_center)

hex_value = bgr_to_hex(pixel_center)


#hex_value = pixel_center[0]

print(hex_value)

cv2.circle(img, (center_x, center_y), 5, (25,25,25), 3)

cv2.imshow("Img", img)
cv2.waitKey(0)
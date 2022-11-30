"""
Purpose:        Driver Code
"""

import Region_of_Interest as ROI
import cv2

image = cv2.imread("./sample_lego_pics/black_lego.jpg")

mapped_image = ROI.MapImage(image)

ROI.ShowLines(mapped_image)

print("End of Session...")

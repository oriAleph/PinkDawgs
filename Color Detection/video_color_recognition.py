"""
Pupose:     Captures frames from webcam and identifies the color being displayed over a specified region
"""


import cv2

cap = cv2.VideoCapture(0)
#sets resolution of webcam
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 1280)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 720)

while True:
    _, frame = cap.read()
    hsv_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2HSV)

    height, width, _= frame.shape

    cx = int(width / 2)
    cy = int(height / 2)    

    pixel_center = hsv_frame[cy,cx]
    hue_value = pixel_center[0]

    print(hue_value)

    #defines color values
    size = 200
    color = "Undefined"
    if hue_value < 5:
        color = "RED"
        size = 110
    elif hue_value < 22:
        color = "ORANGE"
        size = 200
    elif hue_value < 33:
        color = "YELLOW"
        size = 190
    elif hue_value < 78:
        color = "GREEN"
        size = 170
    elif hue_value < 131:
        color = "BLUE"
        size = 140
    elif hue_value < 170:
        color = "VIOLET"
        size = 170
    else:
        color = "RED"
        size = 110
        
    pixel_center_bgr = frame[cy, cx]

    b, g, r = int(pixel_center_bgr[0]), int(pixel_center_bgr[1]), int(pixel_center_bgr[2])
    cv2.rectangle(frame, (5,30),(size, 80), (0,0,0), -1)
    cv2.putText(frame, color, (10, 70), 0, 1.5, (255,255,255), 2)
    cv2.circle(frame, (cx, cy), 5, (25, 25, 25), 3)

    cv2.imshow("Color Identification", frame)

    key = cv2.waitKey(1)

    if key == 27:
        break

cap.release()
cv2.destroyAllWindows()
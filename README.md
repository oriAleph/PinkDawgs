# :mag:  LEGO Brick Finder Project

>The purpose of this project is to develop an iOS application that can make it easier for someone who is visually impaired to identify the type and color of an individual LEGO brick that they might need for their LEGO set.
<br /> <br />

![image](https://github.com/oriAleph/PinkDawgs/blob/main/demo.png)
<br /> <br />

## Table of Contents

- [:star: Installation](#installation)
  - [:sparkles: Requirements](#requirements)
    - :cherry_blossom: iOS Application
    - :cherry_blossom: Coding Notebooks
  - [:sparkles: Build and Run](#build-and-run)
- [:star: Project Components](#project-components)
  - [:sparkles: Building the Models](#building-the-models)
    - :hibiscus: LEGO Type
    - :hibiscus: LEGO Color
  - [:sparkles: Accessibility Features](#accessibility-features)
  - [:sparkles: Database](#database)
<br /> <br /> <br />

## Installation
### Requirements

#### ~ iOS Application ~
- Xcode 13.0 or above
- Valid Apple Developer ID
- Xcode command-line tools 
- [Git Large File Storage](https://git-lfs.com/) (run `brew install git-lfs`)
- [CocoaPods](https://guides.cocoapods.org/using/getting-started.html) to manage Xcode library dependencies (run `sudo gem install cocoapods`)
- A device with iOS 12.0 or above to test the camera feature. If not available, then use one of the iPhone simulators.
<br /> <br />

#### ~ Coding Notebooks ~
- Google Colab was used to run the **LEGO Brick Classification with TensorFlow Lite Model Maker** notebook.
- If you use Jupyter Notebooks instead, you can create a python virtual environment and add it to the Python Kernel. However, at the time of this writing, specific package versions needed to get the code to work are not available to install using pip on macOS. 
<br /> <br />

### Build and Run

1. Clone this GitHub repository: `git clone https://github.com/oriAleph/PinkDawgs.git` and `cd PinkDawgs`
2. Install the pod to generate the workspace file: `cd LEGO\ Brick\ Finder && pod install`
3. Open the project in Xcode with this command: `open LEGO\ Brick\ Finder.xcworkspace`
4. Select the `LEGO Brick Finder` project, and under the `Signing & Capabilities` section, select development team.
5. If you connect an iOS device for the build, grant developer permissions.
- If you’re receiving the “for architecture arm64” error, please refer to this: [Xcode building for iOS Simulator](https://stackoverflow.com/questions/63607158/xcode-building-for-ios-simulator-but-linking-in-an-object-file-built-for-ios-f) 
- If you’re receiving the “building for iOS Simulator-x86_64 but attempting to link with file built for unknown-unsupported a file format ( 0x76 0x65 0x72 0x73 0x69 0x6F 0x6E 0x20 0x68 0x74 0x74 0x70 0x73 0x3A 0x2F 0x2F )” error, please do the following steps: 
  1. Install git-lfs
  2. Delete pods **folder**
  3. Clean pod cache `pod cache clean --all`
  4. Install pod `pod install`
<br /> <br /> <br />

## Project Components

### ~ LEGO Type ~

* [Image Classification](https://www.tensorflow.org/lite/examples/image_classification/overview) is the task of categorizing an image with a unique class, such as labeling a picture of a flower with its type or the condition it’s in. Training this model type requires a dataset of images organized within their respective labels, aka the names of the unique classes/objects. After training, the model will be able to classify new images based on the given categories used in training.

* [Object Detection](https://machinelearningmastery.com/object-recognition-with-deep-learning/) is the process of finding the location of multiple objects in an image. To build an object detection model, you will need an annotated dataset containing the objects and their coordinate positions. 

* For this project, we created an image classification model *to identify one LEGO brick at a time* within a given image. If you want to recognize multiple bricks in a given image, I recommend using an object detection model instead.

* To create a model that classifies LEGO brick images, a pre-trained machine learning model was leveraged to perform [transfer learning](https://machinelearningmastery.com/how-to-use-transfer-learning-when-developing-convolutional-neural-network-models/) by applying the LEGO dataset to it. There are trade-offs based on performance, accuracy, and model size when deciding which model architecture to use for training. While we do want an efficient model, the essential aspect of this project is the accuracy of the predictions.

* [TensorFlow Lite](https://www.tensorflow.org/lite/guide) provides tools for deploying models on mobile, microcontrollers, and other edge devices. We can run an inference - a model prediction - with an iOS Swift application on a device by using a TFLite model.

* [TensorFlow Lite Model Maker](https://www.tensorflow.org/lite/models/modify/model_maker) is a library that simplifies TFLite model training for a custom dataset.

* The code utilizes the [ImageClassifier API](https://www.tensorflow.org/lite/inference_with_metadata/task_library/image_classifier) from the [TensorFlow Lite Task Library](https://www.tensorflow.org/lite/inference_with_metadata/task_library/overview) to run the custom model inference in iOS.

**[insert final data set used]**

### ~ LEGO Color ~
* **[insert]**
<br /> <br /> <br />

### ~ Accessibility Features ~

* Text-to-speech
* Contrast
* Device accessibility integration 
<br /> <br />

# :mag:  LEGO Brick Finder Project

>The purpose of this project is to develop an iOS application that can make it easier for someone who is visually impaired to identify the type and color of an individual LEGO brick that they might need for their LEGO set/project.
<br /> <br />

**Note: update link when merged into main**
![image](https://github.com/oriAleph/PinkDawgs/blob/main/demo.png)
<br /> <br />

## Table of Contents

- [:star: Installation](#installation)
  - [:sparkles: Requirements](#requirements)
    - [:cherry_blossom: iOS Application](#ios-application)
    - [:cherry_blossom: Coding Notebooks](#coding-notebooks)
  - [:sparkles: Build and Run](#build-and-run)
- [:star: Project Components](#project-components)
  - [:sparkles: Building the Models](#building-the-models)
    - [:hibiscus: LEGO Type](#lego-type)
    - [:hibiscus: LEGO Color](#lego-color)
  - [:sparkles: Accessibility Features](#accessibility-features)
  - [:sparkles: Database](#database)
<br /> <br /> <br />

## Installation
### Requirements

#### ~ iOS Application ~
Xcode 13.0 or above
Valid Apple Developer ID
Xcode command-line tools 
[CocoaPods](https://guides.cocoapods.org/using/getting-started.html) to manage Xcode library dependencies (run `sudo gem install cocoapods`)
<br /> A device with iOS 12.0 or above to test the camera feature. If not available, then use one of the iPhone simulators.
<br /> If you’re receiving the “for architecture arm64” error, please refer to this: [Xcode building for iOS Simulator](https://stackoverflow.com/questions/63607158/xcode-building-for-ios-simulator-but-linking-in-an-object-file-built-for-ios-f)
<br /> <br />

#### ~ Coding Notebooks ~
Google Colab is preferred
<br />Install any dependencies asked for when running the Installation and Import sections
<br /> <br /> <br /> <br /> 

### Build and Run

1. Clone this GitHub repository: `git clone https://github.com/oriAleph/PinkDawgs.git` and `cd PinkDawgs`
2. Install the pod to generate the workspace file: `cd LEGO\ Brick\ Finder && pod install`
3. Open the project in Xcode with this command: `open LEGO\ Brick\ Finder.xcworkspace`
4. Select the `LEGO Brick Finder` project and under the `Signing & Capabilities` section select development team.
5. If an iOS device is connected for the build, make sure to grant developer permissions.
<br /> <br /> <br />

## Project Components

### Building the Models

#### ~ LEGO Type ~

* [Image Classification](https://www.tensorflow.org/lite/examples/image_classification/overview) is the task of categorizing an image with a unique class, such as labeling an image of a flower with its type or the condition it’s in. Training this type of model requires a dataset of images organized within their respective labels, aka the names of the unique classes/objects. After training, the model will be able to classify new images based on the given classes used in training. 

* [Object Detection](https://machinelearningmastery.com/object-recognition-with-deep-learning/) is the process of finding the location of multiple objects in an image. To build an object detection model, you will need an annotated dataset containing the objects and their coordinate positions. 

* For this project, an image classification model was used *to identify one LEGO brick at a time* within a given image. If you want to recognize multiple bricks in a given image, I recommend using an object detection model instead.

* To create a model that classifies LEGO brick images, a pre-trained machine learning model was leveraged to perform [transfer learning](https://machinelearningmastery.com/how-to-use-transfer-learning-when-developing-convolutional-neural-network-models/) by applying it to the LEGO dataset. There are trade-offs based on performance, accuracy, and model size when deciding which model architecture to use for training. While we do want an efficient model, the most important aspect of this project is the accuracy of the predictions since we want to provide successful user accessibility.

* [TensorFlow Lite](https://www.tensorflow.org/lite/guide) provides tools for deploying models on mobile, microcontrollers, and other edge devices. We can run an inference - a model prediction - with an iOS Swift application on a device by using a TFLite model. 

* [TensorFlow Lite Model Maker](https://www.tensorflow.org/lite/models/modify/model_maker) is a library that simplifies TFLite model training for a custom dataset.

* In this project, we use the Model Maker to train and export our TFLite model. The current model architecture used for transfer learning is [EfficientNet-Lite0](https://tfhub.dev/tensorflow/efficientnet/lite0/classification/2), which is trained on the [Imagenet 2012](https://www.tensorflow.org/datasets/catalog/imagenet2012) data set (images are organized based on WordNet ordering). EfficientNet is a convolutional neural network architecture that was first published in 2019 in [this paper](https://arxiv.org/abs/1905.11946), and you can view comparisons on performance and accuracy between the different EfficientNet-Lite models [here](https://github.com/tensorflow/tpu/blob/master/models/official/efficientnet/lite/README.md). 

* The dataset I am currently using is from [Joost Hazelzet’s Images of 50 LEGO Bricks Kaggle Dataset](https://www.kaggle.com/datasets/joosthazelzet/lego-brick-images), which has 40,000 images of 50 LEGO bricks rendered in 800 different angles and provides documentation on how to create more. 

* To run the custom model inference in iOS I use the [ImageClassifier API](https://www.tensorflow.org/lite/inference_with_metadata/task_library/image_classifier) from the [TensorFlow Lite Task Library](https://www.tensorflow.org/lite/inference_with_metadata/task_library/overview).
<br /> <br />

#### ~ LEGO Color ~

* [insert]
<br /> <br /> <br /> <br /> 

### Accessibility Features

* Text-to-speech
* Contrast
* Device accessibility integration 
<br /> <br />  <br />

### Database

* [insert]
<br /> <br /> <br />

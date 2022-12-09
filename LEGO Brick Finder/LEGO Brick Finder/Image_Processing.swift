/*
    Image_Processing.swift
    Adapted TFLite Image Classification iOS Example Application
    
    TFLite Inference - the process of running a model on-device in order to provide predictions based on input data.
 
    TFLite Interpreter - to perform an inference with a model it must be run through an interpreter, which is made to minimize load, initialization, and execution delay.
 
    ImageClassifier API - from the TensorFlow Lite Task Library, it has useful features that helps deploy custom image classifiers on mobile apps.
    
    References:
    https://www.tensorflow.org/lite/guide/inference
    https://www.tensorflow.org/lite/inference_with_metadata/task_library/image_classifier
    https://github.com/tensorflow/examples/tree/master/lite/examples/image_classification/ios
 */

import TensorFlowLiteTaskVision
import Foundation
import SwiftUI
import UIKit


/// A result from the `Classifications`.
struct ImageClassificationResult {
  let inferenceTime: Double
  let classifications: Classifications
}

/// Model file information
typealias FileInfo = (name: String, extension: String)

/// This class handles all data preprocessing and makes calls to run inference on a given frame
/// by invoking the TFLite `ImageClassifier`. It then returns the top N results for a successful
/// inference.
class ImageClassificationHelper {

  // MARK: - Model Parameters

  /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
  private var classifier: ImageClassifier

  /// Information about the alpha component in RGBA data.
  private let alphaComponent = (baseOffset: 4, moduloRemainder: 3)

  // MARK: - Initialization

  /// A failable initializer for `ClassificationHelper`. A new instance is created if the model and
  /// labels files are successfully loaded from the app's main bundle. Default `threadCount` is 1.
  init?(modelFileInfo: FileInfo, threadCount: Int, resultCount: Int, scoreThreshold: Float) {
    let modelFilename = modelFileInfo.name
    // Construct the path to the model file.
    guard
      let modelPath = Bundle.main.path(
        forResource: modelFilename,
        ofType: modelFileInfo.extension
      )
    else {
      print("Failed to load the model file with name: \(modelFilename).")
      return nil
    }

    // Configures the initialization options.
    let options = ImageClassifierOptions(modelPath: modelPath)
    options.baseOptions.computeSettings.cpuSettings.numThreads = Int(Int32(threadCount))
    options.classificationOptions.maxResults = resultCount
    options.classificationOptions.scoreThreshold = scoreThreshold

    do {
      classifier = try ImageClassifier.classifier(options: options)
    } catch let error {
      print("Failed to create the interpreter with error: \(error.localizedDescription)")
      return nil
    }
  }

  // MARK: - Internal Methods


  /// Performs image preprocessing, invokes the `ImageClassifier`, and processes the inference
  /// results.

  // func classify(frame pixelBuffer: CVPixelBuffer) -> ImageClassificationResult? {
  // Convert the `CVPixelBuffer` object to an `MLImage` object.
  // guard let mlImage = MLImage(pixelBuffer: pixelBuffer) else { return nil }
      
   func classify() -> ImageClassificationResult? {
       
       /// Convert the input image to MLImage
       guard let image = UIImage (named: "IMG_0676.jpeg"), let mlImage = MLImage(image: image) else { return nil }
       
       // Run inference using the `ImageClassifier{ object.
        do {
          let startDate = Date()
          let classificationResults = try classifier.classify(mlImage: mlImage)
          let inferenceTime = Date().timeIntervalSince(startDate) * 1000

          // As all models used in this sample app are single-head models, gets the classification
          // result from the first (and only) classification head and return to the view controller to
          // display.
          guard let classifications = classificationResults.classifications.first else { return nil }
          return ImageClassificationResult(
            inferenceTime: inferenceTime, classifications: classifications)
        } catch let error {
          print("Failed to invoke the interpreter with error: \(error.localizedDescription)")
          return nil
        }
  }
}





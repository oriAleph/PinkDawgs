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


/// A result from the `Classifications`
struct ImageClassificationResult {
    let inferenceTime: Double
    let classifications: Classifications
}


func Inference(imageName: String) -> ImageClassificationResult? {
    
    // MARK: - Model Parameters
    
    /// TensorFlow Lite `Interpreter` object for performing inference on a given model.
    var classifier: ImageClassifier
    
    /// Information about the alpha component in RGBA data.
    //let alphaComponent = (baseOffset: 4, moduloRemainder: 3)
    
    // MARK: - Initialization
    
    /// Construct the path to the model file.
    let modelName = "model"
    guard
        let modelPath = Bundle.main.path(forResource: modelName, ofType: "tflite")
    else {
        print("Failed to load the model file with name: \(modelName).")
        return nil
    }
    
    /// Configure initialization options.
    let options = ImageClassifierOptions(modelPath: modelPath)
    options.classificationOptions.maxResults = 3
    options.baseOptions.computeSettings.cpuSettings.numThreads = Int(Int32(4))
    options.classificationOptions.scoreThreshold = 0.2

    do {
      classifier = try ImageClassifier.classifier(options: options)
    } catch let error {
      print("Failed to create the interpreter with error: \(error.localizedDescription)")
      return nil
    }
    
    // MARK: - Internal Methods

    /// Convert the input image to MLImage
    guard let image = UIImage (named: imageName), let mlImage = MLImage(image: image)
    else { return nil }
    
    /// Run inference using the `ImageClassifier` object.
    do {
      let startDate = Date()
      /// Run inference
      let classificationResults = try classifier.classify(mlImage: mlImage)
      let inferenceTime = Date().timeIntervalSince(startDate) * 1000

      /// A single-head model gets the classification result from the first (and only) classification head
      guard let classifications = classificationResults.classifications.first
      else { return nil }
        
      /// Return inference information
      return ImageClassificationResult(
        inferenceTime: inferenceTime, classifications: classifications)
    
    } catch let error {
      print("Failed to invoke the interpreter with error: \(error.localizedDescription)")
      return nil
    }
    
}


func FormatResults(row: Int) -> (String, String) {
    
    var fieldName: String = ""
    var info: String = ""
    
    let inferenceResult = Inference(imageName: "IMG_0676.jpg")
    
    guard let tempResult = inferenceResult, tempResult.classifications.categories.count > 0
    else {
        if row == 1 {
            fieldName = "No Results"
            info = ""
        } else {
            fieldName = ""
            info = ""
        }
        return (fieldName, info)
    }
    
    if row < tempResult.classifications.categories.count {
    let category = tempResult.classifications.categories[row]
    fieldName = category.label ?? ""
    info = String(format: "%.2f", category.score * 100.0) + "%"
    } else {
    fieldName = ""
    info = ""
    }

  return (fieldName, info)
}


// For additional inference information ->

enum InferenceInfo: Int, CaseIterable {
    case Resolution
    case InferenceTime
    
    func displayString() -> String {
        var toReturn = ""
        switch self {
        case .Resolution:
            toReturn = "Resolution"
        case .InferenceTime:
            toReturn = "Inference Time"
        }
        return toReturn
    }
}


func FormatInfo(row: Int) -> (String, String) {
    let inferenceResult: ImageClassificationResult? = nil
    let resolution = CGSize.zero
    
    var fieldName: String = ""
    var info: String = ""
    
    guard let inferenceInfo = InferenceInfo(rawValue: row) else {
        return (fieldName, info)
    }
    
    fieldName = inferenceInfo.displayString()
    
    switch inferenceInfo {
    case .Resolution:
        info = "\(Int(resolution.width))x\(Int(resolution.height))"
    case .InferenceTime:
        guard let finalResults = inferenceResult else {
            info = "0ms"
            break
        }
        info = String(format: "%.2fms", finalResults.inferenceTime)
    }
    return (fieldName, info)
}




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
import AVFoundation
import Foundation
import SwiftUI
import UIKit


/// A result from the `Classifications`.
struct ImageClassificationResult {
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
    
    /// A failable initializer. A new instance is created if the model files are successfully loaded
    init?(modelFileInfo: FileInfo, resultCount: Int, scoreThreshold: Float) {
        
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
    
    /// Performs image preprocessing, invokes the `ImageClassifier`, and processes the inference results.
    func classify(Name: String) -> ImageClassificationResult? {
        
        // Convert the input image to MLImage
        guard let image = UIImage (named: Name),
              let mlImage = MLImage(image: image) else { return nil }
        
        // Run inference using the `ImageClassifier` object.
        do {
            let classificationResults = try classifier.classify(mlImage: mlImage)
            
            guard let classifications = classificationResults.classifications.first
            else { return nil }
            
            return ImageClassificationResult(classifications: classifications)
        } catch let error {
            print("Failed to invoke the interpreter with error: \(error.localizedDescription)")
            return nil
        }
    }

}




class Image_Processing {
    
    // MARK: Instance Variables
    private var maxResults = DefaultConstants.maxResults
    private var scoreThreshold = DefaultConstants.scoreThreshold
    private var model: ModelType = .model
    
    // MARK: Run Inference
    private var imageClassificationHelper: ImageClassificationHelper? =
    ImageClassificationHelper(
        modelFileInfo: DefaultConstants.model.modelFileInfo,
        resultCount: DefaultConstants.maxResults,
        scoreThreshold: DefaultConstants.scoreThreshold)
    
    // Results
    func results() -> (String, String) {
        // Pass the image to TensorFlow Lite to perform inference.
        let img_path = "IMG_0676"
        
        guard imageClassificationHelper != nil
        else { fatalError("Model initialization failed.") }
        
        guard imageClassificationHelper?.classify(Name: img_path) != nil
        else { fatalError("Model classification failed.") }
        
        let result = imageClassificationHelper?.classify(Name: img_path)
        
        var fieldName: String = ""
        var info: String = ""
        
        guard let category = result?.classifications.categories[1]
        else {
            fatalError("Failed to extract results")
        }
        
        fieldName = category.label ?? ""
        info = String(format: "%.2f", category.score * 100.0) + "%"
        
        return (fieldName, info)
        
    }
    
}



// MARK: Default Constants
enum DefaultConstants {
  static let maxResults = 3
  static let scoreThreshold: Float = 0.2
  static let model: ModelType = .model
}

// MARK: TFLite model types
enum ModelType: CaseIterable {
    case model
    case efficientnetLite0
    case efficientnetLite1
    case efficientnetLite2
    case efficientnetLite3
    case efficientnetLite4
    
    var modelFileInfo: FileInfo {
        switch self {
        case .model:
            return FileInfo("model", "tflite")
        case .efficientnetLite0:
            return FileInfo("efficientnet_lite0", "tflite")
        case .efficientnetLite1:
            return FileInfo("efficientnet_lite1", "tflite")
        case .efficientnetLite2:
            return FileInfo("efficientnet_lite2", "tflite")
        case .efficientnetLite3:
            return FileInfo("efficientnet_lite3", "tflite")
        case .efficientnetLite4:
            return FileInfo("efficientnet_lite4", "tflite")
        }
    }
    
    var title: String {
        switch self {
        case .model:
            return "Model"
        case .efficientnetLite0:
            return "EfficientNet-Lite0"
        case .efficientnetLite1:
            return "EfficientNet-Lite1"
        case .efficientnetLite2:
            return "EfficientNet-Lite2"
        case .efficientnetLite3:
            return "EfficientNet-Lite3"
        case .efficientnetLite4:
            return "EfficientNet-Lite4"
        }
    }
}

//
//  ViewController.swift
//  SceneDetector_new
//
//  Created by Seoyoung on 20/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import Vision
import CoreML

class ViewController: UIViewController {
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "train_night") else {
            fatalError("Error: invalid image!")
        }
        scene.image = image
    }

    @IBAction func pickImage(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
}

extension ViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false){ () in
            let alert = UIAlertController(title: "", message: "deselected", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: false)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: false){ () in
            let image = info[.editedImage] as? UIImage
            self.scene.image = image
            let ciImage = CIImage(image: image!)
            self.detectScene(image: ciImage!)
        }
    }
    
    func detectScene(image: CIImage){
        answerLabel.text = "Detecting image ..."
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load GooLeNetPlaces model")
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.answerLabel.text = "\(topResult.identifier)"
            }
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
        
    }
    
}

//let article = (["a", "e", "i", "o", "u"].contains(topResult.identifier.first!)) ? "an" : "a"
//
//DispatchQueue.main.async { [weak self] in
//    self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
//}

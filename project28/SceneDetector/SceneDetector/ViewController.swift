//
//  ViewController.swift
//  SceneDetector
//
//  Created by Seoyoung on 20/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let image = UIImage(named: "train_night") else {
            fatalError("no starting image")
        }
        
        scene.image = image
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true)
    }
    
}


extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // didFinishPickingMediaWithInfo info: [String : Any] 에서 String을 UIImagePickerController.InfoKey로 설ㅈ
        dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }
        scene.image = image
        guard let ciImage = CIImage(image: image) else {
            fatalError("couldn't convert UIImage to CIImage")
        }
        detectScene(image: ciImage)
    }
}

extension ViewController: UINavigationControllerDelegate{
    func detectScene(image: CIImage) {
        answerLabel.text = "detecting scene..."
        
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else {
            fatalError("can't load Places ML model")
        }

        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results,
                let topResult = results.first as? VNClassificationObservation else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }

            let article = (["a", "e", "i", "o", "u"].contains(topResult.identifier.first!)) ? "an" : "a"
            
            DispatchQueue.main.async { [weak self] in
                self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
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

//
//  ViewController.swift
//  PhotoTagger
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import Alamofire

let kAuthorization = ""

class ViewController: UIViewController {
    @IBOutlet weak var takePictureButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    fileprivate var tags: [String]?
    fileprivate var colors: [PhotoColor]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            takePictureButton.setTitle("Select Photo", for: UIControl.State())
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        imageView.image = nil
    }
    @IBAction func takePicture(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = false
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = UIImagePickerController.SourceType.camera
        } else {
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .fullScreen
        }
        present(picker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults" {
            guard let controller = segue.destination as? TagColorsViewController else {
                fatalError("Storyboard mis-configuration.")
            }
            controller.tags = tags
            controller.colors = colors
        }
    }
}

extension ViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            dismiss(animated: true)
            return
        }
        imageView.image = image
        takePictureButton.isHidden = true
        progressView.progress = 0.0
        progressView.isHidden = false
        activityIndicatorView.startAnimating()
        
        upload(
            image: image,
            progressCompletion: { [unowned self] percent in
                self.progressView.setProgress(percent, animated: true)
            },
            completion: { [unowned self] tags, colors in
                self.takePictureButton.isHidden = false
                self.progressView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                
                self.tags = tags
                self.colors = colors
                
                self.performSegue(withIdentifier: "ShowResults", sender: self)
        })
        
        dismiss(animated: true)
    }
}



extension ViewController {
    func upload(image: UIImage,
                progressCompletion: @escaping (_ percent: Float) -> Void,
                completion: @escaping (_ tags: [String], _ colors: [PhotoColor]) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            print("Could not get JPEG representation of UIImage")
            return
        }
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(imageData, withName: "imagefile", fileName: "image.jpg", mimeType: "image/jpeg")
        },
            with: ImaggaRouter.content,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress { progress in
                        progressCompletion(Float(progress.fractionCompleted))
                    }
                    upload.validate()
                    upload.responseJSON { response in
                        guard response.result.isSuccess else {
                            completion([String](), [PhotoColor]())
                            return
                        }
                        guard let responseJSON = response.result.value as? [String: Any],
                            let uploadedFiles = responseJSON["uploaded"] as? [Any],
                            let firstFile = uploadedFiles.first as? [String: Any],
                            let firstFileID = firstFile["id"] as? String else {
                                completion([String](), [PhotoColor]())
                                return
                        }
                        
                        self.downloadTags(contentID: firstFileID) { tags in
                            self.downloadColors(contentID: firstFileID) { colors in
                                completion(tags, colors)
                            }
                        }
                    }
                    
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
    }
    
    func downloadTags(contentID: String, completion: @escaping ([String]) -> Void) {
        Alamofire.request(ImaggaRouter.tags(contentID))
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion([String]())
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any],
                    let results = responseJSON["results"] as? [[String: Any]],
                    let firstObject = results.first,
                    let tagsAndConfidences = firstObject["tags"] as? [[String: Any]] else {
                        print("Invalid tag information received from the service")
                        completion([String]())
                        return
                }
                let tags = tagsAndConfidences.compactMap({ dict in
                    return dict["tag"] as? String
                })
                completion(tags)
        }
    }
    
    func downloadColors(contentID: String, completion: @escaping ([PhotoColor]) -> Void) {
        Alamofire.request(ImaggaRouter.colors(contentID))
            .responseJSON { response in
                guard response.result.isSuccess else {
                    completion([PhotoColor]())
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any],
                    let results = responseJSON["results"] as? [[String: Any]],
                    let firstResult = results.first,
                    let info = firstResult["info"] as? [String: Any],
                    let imageColors = info["image_colors"] as? [[String: Any]] else {
                        print("Invalid color information received from service")
                        completion([PhotoColor]())
                        return
                }
                let photoColors = imageColors.compactMap({ (dict) -> PhotoColor? in
                    guard let r = dict["r"] as? String,
                        let g = dict["g"] as? String,
                        let b = dict["b"] as? String,
                        let closestPaletteColor = dict["closest_palette_color"] as? String else {
                            return nil
                    }
                    
                    return PhotoColor(red: Int(r), green: Int(g), blue: Int(b), colorName: closestPaletteColor)
                })
                completion(photoColors)
        }
        
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

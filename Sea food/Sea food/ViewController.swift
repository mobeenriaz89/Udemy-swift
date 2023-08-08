//
//  ViewController.swift
//  Sea food
//
//  Created by Mobeen Riaz on 05/08/2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
    }
    
    @IBAction func didTapCameraBtn(_ sender: UIBarButtonItem){
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[.originalImage] as? UIImage{
            imageview.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage)else{
                fatalError("Error loading CIIMAGE")
            }
            detectImage(image: ciimage)
        }
        imagePicker.dismiss(animated: true)
    }
    
    private func detectImage(image: CIImage){
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            fatalError("Error loading vision core ml model")
        }
        
        let request = VNCoreMLRequest(model: model,completionHandler: { req, err in
            guard let results = req.results as? [VNClassificationObservation] else{
                fatalError("Error loading results from request")
            }
            print(results.first)
            self.navigationItem.title = results.first?.identifier
        })
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([request])
        } catch {
            print("\(error)")
        }
        
        
    }
    
    
}


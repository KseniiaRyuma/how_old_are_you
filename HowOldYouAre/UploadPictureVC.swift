//
//  UploadPictureVC.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/13/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//  Color #684A7C


import UIKit
import ProjectOxfordFace

class UploadPictureVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var myImageView: UIImageView!
    var hasSelectedImage: Bool = false
    var numOfFaces: Int = 0
    var faceSquareCheck: Bool = false
    
    let picker = UIImagePickerController()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
        if (hasSelectedImage && faceSquareCheck){
            self.clearSubviews()
        }
        hasSelectedImage = true
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func shootPhoto(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            hasSelectedImage = true
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.cameraCaptureMode = .photo
            picker.modalPresentationStyle = .fullScreen
            present(picker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }

    
    //MARK: - Delegates
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]){
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        dismiss(animated:true, completion: nil)
    
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    @IBAction func checkAge(_ sender: UIButton) {
        if !hasSelectedImage {
            let alert = UIAlertController(
                title: "Select Photo",
                message: "Please, choose a photo",
                preferredStyle: .alert)
            let ok = UIAlertAction(
                title: "OK",
                style:.default,
                handler: nil)
            alert.addAction(ok)
            present(
                alert,
                animated: true,
                completion: nil)
        } else {
            /*MPOFaceServiceClient(subscriptionKey: "d4a20afb3e4844baaf5c59f22a8654c1").detect(withUrl: "http://www.uni-regensburg.de/Fakultaeten/phil_Fak_II/Psychologie/Psy_II/beautycheck/english/durchschnittsgesichter/m(01-32)_gr.jpg", returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: [1, 2], completionBlock: { (faces, error) in
               
                print(1)
            })*/
            
            if let img = myImageView.image, let imgData = UIImageJPEGRepresentation(img, 1.0) {
                MPOFaceServiceClient(subscriptionKey: "d4a20afb3e4844baaf5c59f22a8654c1").detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: [1, 2]) { (faces, error) in
                    if let faces = faces, error == nil {
                        self.faceSquareCheck = true
                        self.numOfFaces = 0
                        for face in faces {
                            self.numOfFaces += self.makeFaceSquare(face: face)
                            print(face.attributes.age)
                        }
                    }
                }
                
            }
        }
    }
    func makeFaceSquare(face: MPOFace) -> Int{
        let scaleW  = Double(self.myImageView.image!.size.width / (self.myImageView.bounds.width))
        let scaleH = Double(self.myImageView.image!.size.height / (self.myImageView.bounds.height))
        let overlay = UIView(frame: CGRect(x: Double(face.faceRectangle.left) / scaleW, y: Double(face.faceRectangle.top) / scaleH, width: Double(face.faceRectangle.width) / scaleW, height: Double(face.faceRectangle.height) / scaleH))
        overlay.tag = 100
        overlay.layer.borderWidth = 2
        overlay.layer.borderColor = UIColor.white.cgColor
        
        let label = UILabel(frame: CGRect(x: (Double(face.faceRectangle.left)/scaleW), y: (Double(face.faceRectangle.top)/scaleH)-25, width: 25, height: 25))
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.backgroundColor = UIColor(white: 1.0, alpha: 0.7)
        label.text = String(describing: Int(face.attributes.age!))
        
        label.tag = 100
        
        
        self.myImageView.addSubview(overlay)
        self.myImageView.addSubview(label)
        return 1
    }
    
    func clearSubviews(){
        for z in 0...self.numOfFaces {
            print(z)
            if let viewWithTag = self.myImageView.viewWithTag(100){
                viewWithTag.removeFromSuperview()
                print    ("removed")
            } else {
                print("tag not found")
            }
        }
    }
    
    @IBAction func saveImage(sender: UIBarButtonItem){
        if (myImageView.image != nil) {
            // Create the image context to draw in
            UIGraphicsBeginImageContextWithOptions(myImageView.bounds.size, false, UIScreen.main.scale)
        
            // Get that context
            let context = UIGraphicsGetCurrentContext()
        
            // Draw the image view in the context
            myImageView.layer.render(in: context!)
        
            // You may or may not need to repeat the above with the imageView's subviews
            // Then you grab the "screenshot" of the context
            let image = UIGraphicsGetImageFromCurrentImageContext()
        
            // Be sure to end the context
            UIGraphicsEndImageContext()
        
            // Finally, save the image
            UIImageWriteToSavedPhotosAlbum(image!, self, #selector(notifyImageSaved), nil)
        }
    }
    
    //  - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

    func notifyImageSaved(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        let alert = UIAlertController(title: "Error", message: "Sign in failed, try again", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}


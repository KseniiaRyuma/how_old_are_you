//
//  UploadPictureVC.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/13/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit
import ProjectOxfordFace

class UploadPictureVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    @IBOutlet weak var myImageView: UIImageView!
    var hasSelectedImage: Bool = false
    
    let picker = UIImagePickerController()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        print(10)
        print(myImageView.image)
        print(myImageView)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func photoFromLibrary(_ sender: UIButton) {
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
                        for face in faces {
                            let scale  = Double(self.myImageView.image!.size.width / (self.myImageView.bounds.width))
                            let overlay = UIView(frame: CGRect(x: Double(face.faceRectangle.left) / scale, y: Double(face.faceRectangle.top) / scale, width: Double(face.faceRectangle.width) / scale, height: Double(face.faceRectangle.height) / scale))
                            overlay.layer.borderWidth = 2
                            overlay.layer.borderColor = UIColor.red.cgColor
                            self.myImageView.addSubview(overlay)
                            print(face.faceRectangle)
                            print(face.attributes.age)
                        }
                    }
                }
                
                
                /*FaceService.instance.client?.detect(with: imgData, returnFaceId: true, returnFaceLandmarks: false, returnFaceAttributes: [MPOFaceAttributeTypeAge, MPOFaceAttributeTypeGender], completionBlock: { (faces:[MPOFace]?,error: NSError?) in
                    print(3)
                    if error == nil {
                        var faceId: [String]?
                        for face in faces! {
                            faceId?.append(face.faceId)
                            print(face.faceRectangle)
                            print(face.attributes.age)
                        }
                        
                    }
                } as! MPOFaceArrayCompletionBlock)*/
            }
        }
    }
}

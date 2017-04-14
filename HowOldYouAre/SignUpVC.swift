//
//  SignUpVC.swift
//  HowOldYouAre
//
//  Created by Dmitry Ryuma on 4/8/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit
import Firebase


class SignUpVC: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    
    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var fb_signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleRegister(){
        guard let email = emailTextfield.text else { return }
        guard let password = passwordTextfield.text else { return }
        guard let name = nameTextfield.text else { return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            if error != nil{
                print(error)
                return
            }
            
            //successfully authenticated user
            let dbRef = FIRDatabase.database().reference()
            let userReference = dbRef.child("Users")
            let values = ["name" : name, "email": email]
            userReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil{
                    print(err)
                    return
                }
                print("User saved successfully into Firebase db")
                self.performSegue(withIdentifier: "signupToMain", sender: self)
            
            })
            
        })
    }

}

//
//  LoginVC.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/7/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
//        if FIRAuth.auth()?.currentUser != nil {
//            self.performSegue(withIdentifier: "loginToMain", sender: self)
//        }
        
        email.layer.backgroundColor = UIColor.white.cgColor
        email.layer.masksToBounds = false
        email.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        email.layer.shadowRadius = 2.0
        email.layer.shadowColor = UIColor.black.cgColor
        email.layer.shadowOpacity = 0.5
        email.layer.shadowRadius = 0.0
        email.layer.cornerRadius = 10
        
        password.layer.backgroundColor = UIColor.white.cgColor
        password.layer.masksToBounds = false
        password.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        password.layer.shadowRadius = 2.0
        password.layer.shadowColor = UIColor.black.cgColor
        password.layer.shadowOpacity = 0.5
        password.layer.shadowRadius = 0.0
        password.layer.cornerRadius = 10
        
        loginBut.layer.cornerRadius = 10
        loginBut.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        loginBut.layer.shadowRadius = 2.0
        loginBut.layer.shadowColor = UIColor.black.cgColor
        loginBut.layer.shadowOpacity = 0.5
        loginBut.layer.shadowRadius = 0.0
        loginBut.layer.cornerRadius = 10
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        loginBut.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
    }
    
    func handleLogin() {
        guard let emailText = email.text else { return }
        guard let passwordText = password.text else { return }
        
        if (emailText != "" && passwordText != "") { //make sure the fields are not empty
            FIRAuth.auth()?.signIn(withEmail: emailText, password: passwordText, completion: {(user, error) in
                if error == nil{
                    self.performSegue(withIdentifier: "loginToMain", sender: nil)
                }else{
                    let alert = UIAlertController(title: "Error", message: "Sign in failed, try again", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
            })
            
        } else{ // one of the fields was left empty
            let alert = UIAlertController(title: "Error", message: "Enter Email and Password", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
    }
}

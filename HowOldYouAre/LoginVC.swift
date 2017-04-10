//
//  LoginVC.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/7/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginBut: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
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
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

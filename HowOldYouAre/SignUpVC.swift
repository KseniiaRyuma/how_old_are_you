//
//  SignUpVC.swift
//  HowOldYouAre
//
//  Created by Dmitry Ryuma on 4/8/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var `continue`: UIButton!
    
    @IBOutlet weak var fb_signUp: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

//
//  AppNavigationController.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/12/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import UIKit

class AppNavigationController: UINavigationController{
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let height: CGFloat = 35
        let bounds = self.navigationBar.bounds
        self.navigationBar.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height + height)
        self.navigationBar.barTintColor = UIColor.white
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName: UIFont.systemFont(ofSize: 30)]
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)
    }
}



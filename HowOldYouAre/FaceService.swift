//
//  FaceService.swift
//  HowOldYouAre
//
//  Created by Kseniia Ryuma on 4/14/17.
//  Copyright © 2017 Kseniia Ryuma. All rights reserved.
//

import ProjectOxfordFace

class FaceService {
    
    static let instance = FaceService()
    let client = MPOFaceServiceClient(subscriptionKey: "d4a20afb3e4844baaf5c59f22a8654c1")
}

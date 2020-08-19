//
//  ViewController.swift
//  HealthTest
//
//  Created by TechCampus on 8/19/20.
//  Copyright © 2020 TechCampus. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HealthKit.init()
    }

}


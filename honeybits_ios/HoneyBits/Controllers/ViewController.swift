//
//  ViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/1/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import DependencyInjector

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func prepareView() {
        
    }


}


extension ViewController : RecursiveDismissDelegate {
    func dismissIt() {
        
    }
    
    func dismissOnLogin() {
       prepareView()
    }
    
    
}

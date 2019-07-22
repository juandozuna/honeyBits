//
//  FirstTimeLoginViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/20/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class FirstTimeLoginViewController: UIViewController {

    var backdropDelegate: AuthBackdropDelegate?
    var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        
        backdropDelegate?.isBackdropActive = true
    }
    
    @IBAction func normalSignInBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! LoginSelectViewController
            vc.delegate = delegate
            vc.backdropDelegate = backdropDelegate
        }
    }
    
    func configureNavController() {
        navigationController?.navigationController?.modalPresentationStyle = .fullScreen
    }
    
}

//
//  LoginSelectViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class LoginSelectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! SignInViewController
            vc.dimissiveDelegate = self;
        }
    }
    
    func goToSignIn(){
        let sb = UIStoryboard(name: "UserAuthentication", bundle: nil)
        let controller = sb.instantiateViewController(withIdentifier: "signInForm")
        self.present(controller, animated: true, completion: nil)
    }

}

extension LoginSelectViewController : RecursiveDismissDelegate {
    func dismissOnLogin() {
        
    }
    
    func dismissIt() {
        dismiss(animated: true, completion: nil)
    }
}

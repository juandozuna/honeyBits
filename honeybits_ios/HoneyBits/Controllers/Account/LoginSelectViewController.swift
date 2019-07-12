//
//  LoginSelectViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/4/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class LoginSelectViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    var delegate: LoginDelegate?
    var backdropDelegate: AuthBackdropDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGestures()
        backdropDelegate?.isBackdropActive = true
    }
    
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! SignInViewController
            vc.dimissiveDelegate = self;
            vc.delegate = delegate
            vc.backdropDelegate = backdropDelegate
        }
    }
    
    @objc func dimsissView(_ gestureRecognizer: UITapGestureRecognizer) {
        dismissIt()
    }
    
    func setTapGestures(){
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimsissView(_:))))
    }

}

extension LoginSelectViewController : RecursiveDismissDelegate {
    func dismissOnLogin() {
    
    }
    
    func dismissIt() {
        backdropDelegate?.isBackdropActive = false
        dismiss(animated: true, completion: nil)
    }
}



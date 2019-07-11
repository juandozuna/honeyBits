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
    override func viewDidLoad() {
        super.viewDidLoad()
        setTapGestures()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func SignInBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! SignInViewController
            vc.dimissiveDelegate = self;
            if let loginDelegate = delegate {
                vc.delegate = loginDelegate
            }
        }
    }
    
    @objc func dimsissView(_ gestureRecognizer: UITapGestureRecognizer) {
        print("HEY THERE DISMISSINg")
        dismiss(animated: true, completion: nil)
    }
    
    func setTapGestures(){
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dimsissView(_:))))
    }

}

extension LoginSelectViewController : RecursiveDismissDelegate {
    func dismissOnLogin() {
    
    }
    
    func dismissIt() {
        dismiss(animated: true, completion: nil)
    }
}

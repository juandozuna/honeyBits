//
//  FirstTimeLoginViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/20/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton

class FirstTimeLoginViewController: UIViewController {

    var backdropDelegate: AuthBackdropDelegate?
    var delegate: LoginDelegate?
    @IBOutlet weak var clientBtn: PMSuperButton!
    @IBOutlet weak var keeperBtn: PMSuperButton!
    
    var selectedRol: UserRoles = .Customer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavController()
        
        clientBtn.tag = UserRoles.Customer.rawValue
        keeperBtn.tag = UserRoles.Keeper.rawValue
        
        backdropDelegate?.isBackdropActive = true
    }
    
    @IBAction func normalSignInBtn(_ sender: Any) {
        performSegue(withIdentifier: "goToSignIn", sender: self)
    }
    
    @IBAction func continueRegistration(_ sender: UIButton) {
        
        selectedRol = UserRoles(rawValue: sender.tag) ?? UserRoles.Customer
        performSegue(withIdentifier: "goToCustomerRegister", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignIn" {
            let vc = segue.destination as! LoginSelectViewController
            vc.delegate = delegate
            vc.backdropDelegate = backdropDelegate
        }
        
        if segue.identifier == "goToCustomerRegister" {
            let vc = segue.destination as! CustomerRegistrationFormViewController
            vc.delegate = delegate
            vc.backdropDelegate = backdropDelegate
            vc.userType = selectedRol
        }
    }
    
    func configureNavController() {
        navigationController?.navigationController?.modalPresentationStyle = .fullScreen
    }
    
}

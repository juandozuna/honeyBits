//
//  CustomerHomeViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/10/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeViewController: CustomerLoginViewController {

    @IBOutlet weak var guestView: GuestView!
    
    var userView: UIView?
    var userController: CustomerHomeUserController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInSegueIdentifier = "goToSignIn"
        
        guestView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfLoggedIn()
    }
    
    override func checkIfLoggedIn() {
        super.checkIfLoggedIn()
        showUserView(accountService.userIsLoggedIn)
        
    }
    
    private func showUserView(_ visible: Bool) {
        if visible {
            setupUserView()
        }
        guestView.isHidden = visible
        userView?.isHidden = !visible
    }
    
    private func setupUserView() {
        if userView == nil {
            userView = createUserView()
            userView?.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(userView!)
            view.addConstraintsWithFormat("H:|[v0]|", views: userView!)
            view.addConstraintsWithFormat("V:|[v0]|", views: userView!)
        }
    }
    
    private func createUserView() -> UIView {
        let uv = UIView()
        uv.translatesAutoresizingMaskIntoConstraints = false
        
        userController = CustomerHomeUserController()
        addChild(userController!)
        let userControllerView = userController!.view!
        userControllerView.translatesAutoresizingMaskIntoConstraints = false
        uv.addSubview(userControllerView)
        uv.addConstraintsWithFormat("H:|[v0]|", views: userControllerView)
        uv.addConstraintsWithFormat("V:|[v0]|", views: userControllerView)
        return uv
    }

}

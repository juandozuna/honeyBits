//
//  CustomerYouViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import PMSuperButton

class CustomerYouViewController: CustomerLoginViewController {

    @IBOutlet var bgView: UIView!
    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var guestViewComponent: GuestView!
    @IBOutlet weak var signOutBtn: PMSuperButton!
    @IBOutlet weak var keeperViewBtn: PMSuperButton!
    @IBOutlet weak var svHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnsStackView: UIStackView!
    @IBOutlet weak var svTopConstraint: NSLayoutConstraint!
    
    private var oneBtnHeight: Int = 47
   
    override func viewDidLoad() {
        super.viewDidLoad()
        guestViewComponent.delegate = self
        signInSegueIdentifier = "goToSignIn"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func checkIfLoggedIn() {
        let isLogged = accountService.userIsLoggedIn
        showGuestView(isLogged)
        if isLogged {
            signOutBtn.isHidden = false
            svTopConstraint.constant = -235
        } else {
            signOutBtn.isHidden = true
            keeperViewBtn.isHidden = true
            svTopConstraint.constant = 10
        }
        
        if let user = accountService.loggedUser {
            let show = user.rol! == .Keeper
            keeperViewBtn.isHidden = !show
        }
        
        updateStackViewConstraint()
        
        super.checkIfLoggedIn()
    }
    
    private func updateStackViewConstraint() {
        var count = 0;
        for item in btnsStackView.arrangedSubviews {
            if !item.isHidden {
                count = count + 1
            }
        }
        
        let newHeight = count * oneBtnHeight
        
        svHeightConstraint.constant = CGFloat(newHeight)
    }
    
    private func showGuestView(_ value: Bool) {
        guestView.isHidden = value
    }
    
    private func goToKeeperController() {
        setRootViewToKeeperMainController()
    }

    @IBAction func signOutBtnPressed(_ sender: Any) {
        accountService.signOut()
        checkIfLoggedIn()
    }
    
    @IBAction func goToKeeperView(_ sender: Any) {
        goToKeeperController()
    }
    
    
}

//
//  LoginViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerLoginViewController: UIViewController, LoginDelegate, SignInDeletegate, AuthBackdropDelegate {
    var signInSegueIdentifier: String?
    let accountService: IAccountService = AccountService()
    var backdropView: UIView?
    
    private var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    @objc var isBackdropActive: Bool {
        get {
            return !backdropView!.isHidden
        }
        set {
            fadeBackdropView(newValue, duration: 0.35)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfLoggedIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkIfLoggedIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == signInSegueIdentifier! {
            let navController = segue.destination as! UserAuthenticationNavigationController
            navController.backdropDelegate = self
            navController.loginDelegate = self
            let vc = navController.topViewController as! LoginSelectViewController
            vc.delegate = self
            vc.backdropDelegate = self
        }
    }
    
    func setRootViewToKeeperMainController() {
        let mainKeeperController = viewControllerFromStoryboard(storyboard: "KeeperMain", withIdentifier: "keeperMainTabController") as! KeeperTabBarController
        mainKeeperController.customizableViewControllers = []
        let mainNavController = appDelegate!.window?.rootViewController as! MainNavigationController
        mainNavController.setViewControllers([mainKeeperController], animated: true)
    }
    
    func logIn() {
        checkIfLoggedIn()
    }
    
    func logOut() {
        checkIfLoggedIn()
    }
    
    func checkIfLoggedIn() {
        if accountService.userIsLoggedIn {
            setRootViewControllerDependingOnLoggedUserRole()
        }
    }
    
    func signIn() {
        performSegue(withIdentifier: signInSegueIdentifier!, sender: self)
    }
    
    func setRootViewControllerDependingOnLoggedUserRole() {
        if let user = accountService.loggedUser {
            if user.rol == UserRoles.Keeper {
                setRootViewToKeeperMainController()
            }
        }
    }
    
    
    
    private func setupBackdropView(isHidden: Bool) {
        if backdropView == nil {
            backdropView = UIView();
            backdropView?.translatesAutoresizingMaskIntoConstraints = false
            backdropView?.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
            backdropView?.isHidden = isHidden
            
            let backView = backdropView!
            view.addSubview(backView)
            view.addConstraintsWithFormat("H:|[v0]|", views: backView)
            view.addConstraintsWithFormat("V:|[v0]|", views: backView)
        }
    }
    
    
    private func fadeBackdropView(_ visible: Bool, duration: TimeInterval) {
        setupBackdropView(isHidden: !visible)
        if visible {
            backdropView!.alpha = 0.0
            backdropView!.isHidden = !visible
            UIView.animate(withDuration: duration, animations: {
                self.backdropView!.alpha = 1.0
            }, completion: nil)
        } else {
            UIView.animate(withDuration: duration, animations: {
                self.backdropView!.alpha = 0.0
            }) { (val) in
                self.backdropView!.isHidden = !visible
            }
        }
    }
}

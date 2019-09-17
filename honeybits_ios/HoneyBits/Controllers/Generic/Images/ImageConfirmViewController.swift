//
//  ImageConfirmViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/16/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class ImageConfirmViewController : UIViewController {
    
    var currentViewController: UIViewController!
    
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    var imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "loading-gic")
        iv.contentMode = UIImageView.ContentMode.scaleAspectFit
        return iv
    }()
    
    var navBar: UINavigationBar = {
        let nb = UINavigationBar()
        nb.translatesAutoresizingMaskIntoConstraints = false
        return nb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        mainViewSetup()
        presentImageView()
        //addTopNavigationBar()
    }
    
    private func mainViewSetup() {
        view.backgroundColor = .white
    }
    
    private func presentImageView() {
        view.addSubview(imageView)
        view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        view.addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }
    
//    private func addTopNavigationBar() {
//        view.addSubview(navBar)
//        view.addConstraintsWithFormat("H:|[v0]|", views: navBar)
//        view.addConstraintsWithFormat("V:|[v0(60)]", views: navBar)
//        navBar.backgroundColor = .red
//        let rightButtonItem = UIBarButtonItem(title: "Confirm", style: .plain, target: self, action: #selector(self.rightNavBarBtnAction))
//        navBar.topItem?.rightBarButtonItem = rightButtonItem
//    }
//
    @objc private func rightNavBarBtnAction() {
        showHudMessage("Hello", type: nil)
    }
}

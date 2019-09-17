//
//  ImageConfirmViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/16/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        mainViewSetup()
        presentImageView()
        buttonsSetup()
    }
    
    private func mainViewSetup() {
        view.backgroundColor = .flatBlack()
    }
    
    private func presentImageView() {
        view.addSubview(imageView)
        view.addConstraintsWithFormat("H:|[v0]|", views: imageView)
        view.addConstraintsWithFormat("V:|[v0]|", views: imageView)
    }
    
    private func buttonsSetup() {
        let buttonWidth = ((view.bounds.width / 2) - 36)
        let buttonHeight: CGFloat = 100
        
        let approveBtn = UIButton()
        approveBtn.backgroundColor = .blue
        approveBtn.setTitleColor(.flatOrange(), for: .normal)
        approveBtn.titleLabel?.text = "Accept"
        approveBtn.addTarget(self, action: #selector(self.approveBtn), for: .touchUpInside)
        approveBtn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(approveBtn)
       
        
        let cancelBtn = UIButton()
        cancelBtn.backgroundColor = .red
        cancelBtn.setTitleColor(.flatOrangeColorDark(), for: .normal)
        cancelBtn.titleLabel?.text = "Cancel"
        cancelBtn.addTarget(self, action: #selector(self.cancelBtn), for: .touchUpInside)
        view.addSubview(cancelBtn)

        NSLayoutConstraint.activate([
            cancelBtn.widthAnchor.constraint(equalToConstant: buttonWidth),
            cancelBtn.heightAnchor.constraint(equalToConstant: buttonHeight),
            cancelBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -6),
            cancelBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            approveBtn.widthAnchor.constraint(equalToConstant: buttonWidth),
            approveBtn.heightAnchor.constraint(equalToConstant: buttonHeight),
            approveBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            approveBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
    }
    
    @objc private func approveBtn() {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc private func cancelBtn() {
        currentViewController.dismiss(animated: true, completion: nil)
    }
}

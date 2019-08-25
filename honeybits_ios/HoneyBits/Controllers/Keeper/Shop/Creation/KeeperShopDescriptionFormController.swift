//
//  KeeperShopLogoFormController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/20/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class KeeperShopDescriptionFormController : UIViewController {
    
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var descriptionTv: UITextView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var noTextView: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    
    @objc func bgViewTapListener(_ sender: UITapGestureRecognizer) {
        resignBeingResponder()
    }
    
    private func controllerSetup() {
        setupGestureListeners()
        showNoInputText()
        descriptionViewSetup()
    }
    
    private func descriptionViewSetup() {
        descriptionContainerView.layer.shadowColor = UIColor.black.cgColor
        descriptionContainerView.layer.shadowOpacity = 0.2
        descriptionContainerView.layer.shadowOffset = .zero
        descriptionContainerView.layer.shadowRadius = 3
        
        descriptionTv.layer.cornerRadius = 10
        descriptionContainerView.layer.cornerRadius = 10
        
        descriptionTv.delegate = self
    }
    
    private func setupGestureListeners() { 
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapListener(_:))))
    }
    
    private func resignBeingResponder() {
        if descriptionTv.isFirstResponder {
            descriptionTv.resignFirstResponder()
        }
    }
    
    private func showNoInputText() {
        let hidden = !descriptionTv.text!.isEmpty
        
        noTextView.isHidden = hidden
        
        descriptionTv.backgroundColor = hidden ? .white : UIColor.flatWhite()
    }
}

extension KeeperShopDescriptionFormController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        showNoInputText()
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        noTextView.isHidden = true
        descriptionTv.backgroundColor = .white
        return true;
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        showNoInputText()
    }
}

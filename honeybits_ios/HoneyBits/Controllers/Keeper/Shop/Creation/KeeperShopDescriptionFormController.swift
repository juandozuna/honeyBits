//
//  KeeperShopLogoFormController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/20/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework
import PMSuperButton
import SwiftValidators

class KeeperShopDescriptionFormController : UIViewController {
    
    @IBOutlet weak var descriptionContainerView: UIView!
    @IBOutlet weak var descriptionTv: UITextView!
    @IBOutlet var bgView: UIView!
    @IBOutlet weak var noTextView: UILabel!
    @IBOutlet weak var createShopBtn: PMSuperButton!
    var delegate: CreateShopDelegate?
    
    var shopService = ShopService()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.color = .flatOrange()
        aiv.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        aiv.isHidden = true
        return aiv;
    }()
    
    var shopRegistrationModel: ShopModelRegistration?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    
    @objc func bgViewTapListener(_ sender: UITapGestureRecognizer) {
        resignBeingResponder()
        dismiss(animated: true, completion: nil)
    }
    
    private func controllerSetup() {
        setupGestureListeners()
        showNoInputText()
        descriptionViewSetup()
        updateBtnStatus()
        activityIndicatorViewSetup()
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
    
    private func activityIndicatorViewSetup() {
        view.addSubview(activityIndicatorView)
        view.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
        view.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)
        
        activityIndicatorView.isHidden = true
    }
    
    private func setupGestureListeners() { 
        bgView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.bgViewTapListener(_:))))
    }
    
    private func resignBeingResponder() {
        if descriptionTv.isFirstResponder {
            descriptionTv.resignFirstResponder()
        }
    }
    
    private func updateBtnStatus() {
        let value = descriptionTv.text!
        let validationResult = Validator.required().apply(value)
        if validationResult {
            createShopBtn.backgroundColor = .flatOrange()
            createShopBtn.isEnabled = true
        } else {
            createShopBtn.backgroundColor = .flatGray()
            createShopBtn.isEnabled = false
        }
    }
    
    private func showNoInputText() {
        let hidden = !descriptionTv.text!.isEmpty
        
        noTextView.isHidden = hidden
        
        descriptionTv.backgroundColor = hidden ? .white : UIColor.flatWhite()
    }
    
    private func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    private func createShop() {
        shopRegistrationModel?.shopDescription = descriptionTv.text!
        startLoading()
        shopService.createShop(createModel: shopRegistrationModel!) { (status, shopModel) in
            if status == .Success {
                print(shopModel!)
                self.delegate?.shopCreated()
                self.dismiss(animated: true, completion: nil)
                self.stopLoading()
            } else if status == .ServerError {
                self.showAlertMessage("Server Error", title: "There was an error trying to comunicate with server", completion: {
                    self.dismiss(animated: true, completion: nil)
                    self.stopLoading()
                })
            }
        }
    }
    
    @IBAction func createShopBtnPressed(_ sender: Any) {
        createShop()
    }
    
}

extension KeeperShopDescriptionFormController : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        showNoInputText()
        updateBtnStatus()
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

//
//  File.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/16/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import AVKit

class ImageMediaHandler : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var currentViewController: UIViewController!
    var imagePickedBlock: ((_ data: Data?) -> Void)?
    
    func camera() {
        self.pickerGeneric(type: .camera)
    }
    
    func photoLibrary() {
        self.pickerGeneric(type: .photoLibrary)
    }
    
    private func pickerGeneric(type: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(type) {
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = type
            currentViewController.present(pickerController, animated: true, completion: nil)
        }
    }
    
    private func showActionSheetWithOptions(_ vc: UIViewController) {
        currentViewController = vc
        let alertController = UIAlertController(title: NSLocalizedString("SelectImageSource", value: "Select Image Source", comment: ""), message: nil, preferredStyle: .actionSheet)
        
        let photoLibraryAction = UIAlertAction(title: NSLocalizedString("PhotoLibrary", value: "Photo Library", comment: ""), style: .default) { (action) in
            self.photoLibrary()
        }
        
        let cameraAction = UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default) { (action) in
            self.camera()
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel) { (action) in
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(photoLibraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        currentViewController.present(alertController, animated: true, completion: nil)
    }
    
    func showActionSheet(vc: UIViewController){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            self.showActionSheetWithOptions(vc)
            return
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (success) in
                if success {
                    self.showActionSheetWithOptions(vc)
                }
            }
            return
        case .denied:
            currentViewController.showHudMessage("Access Denied To Media", type: .info)
            return
        case .restricted:
            currentViewController.showHudMessage("Media is restricted, proceed to settings and update permissions", type: .info)
        @unknown default:
            return
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentViewController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let data = image.pngData()
            self.imagePickedBlock?(data)
        } else {
            currentViewController.showHudMessage("Error retrieving image", type: .error)
        }
        currentViewController.dismiss(animated: true, completion: nil)
    }
}

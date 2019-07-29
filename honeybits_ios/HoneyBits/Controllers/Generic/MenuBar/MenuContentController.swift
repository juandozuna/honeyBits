//
//  MenuContentController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MenuContentController: UIViewController {
    
    var viewControllers: [UIViewController] = []
    var contentCollection: MenuContentCollectionView = {
        let cv = MenuContentCollectionView()
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = UIColor.green
    }

    
    private func setupController() {
        addChildControllers()
        
        contentCollection.dataSource = self
        contentCollection.delegate = self
        contentCollection.isPagingEnabled = true
    }
    
    private func addChildControllers() {
        for vc in viewControllers {
            addChild(vc)
        }
    }
    


}


//MARK:- Collection View Datasource and Delegate methods
extension MenuContentController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuContentCollectionView.cellId, for: indexPath) as! MenuContentCell
        cell.viewController = viewControllers[indexPath.item]
        return cell
    }
    
}

extension MenuContentController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = view.frame
        return CGSize(width: frame.width, height: frame.height)
    }
}

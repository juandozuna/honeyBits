//
//  MenuContentController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MenuContentController: UIViewController {
    
    var viewControllers: [UIViewController?] = []
    var parentController: MenuBarMainController?
    var contentCollectionView: MenuContentCollectionView = {
        let cv = MenuContentCollectionView()
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupView()
    }
    
    func scroll(to position: Int) {
        let indexPath = IndexPath(item: position, section: 0)
        contentCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition(rawValue: 0), animated: true)
    }
    
    private func setupView() {
        contentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentCollectionView)
        view.addConstraintsWithFormat("H:|[v0]|", views: contentCollectionView)
        view.addConstraintsWithFormat("V:|[v0]|", views: contentCollectionView)
    }

    
    private func setupController() {
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.isPagingEnabled = true
    }

}


//MARK:- Collection View Datasource and Delegate methods
extension MenuContentController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var count = 0
        for v in viewControllers {
            if v != nil {
                count += 1
            }
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuContentCollectionView.cellId, for: indexPath)
        if let vc = viewControllers[indexPath.item] {
            addChild(vc)
            cell.contentView.addSubview(vc.view)
            cell.contentView.addConstraintsWithFormat("H:|[v0]|", views: vc.view)
            cell.contentView.addConstraintsWithFormat("V:|[v0]|", views: vc.view)
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollOffsetX = scrollView.contentOffset.x
        parentController?.contentViewScrolling(offset: scrollOffsetX)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x / view.frame.width)
        parentController?.setActiveMenuBarItem(at: index)
    }
}

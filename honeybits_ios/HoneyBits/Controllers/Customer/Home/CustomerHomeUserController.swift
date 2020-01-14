//
//  CustomerHomeUserViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/31/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class CustomerHomeUserController : UIViewController {
    
    private var productService: ProductService = ProductService()
    private var headerCellId: String = "headerCell"
    private var footerCellId: String = "footerCell"
    private var customerHeaderCellId: String = "customerHeaderCell"
    private var colViewContainerCell: String = "contentCell"
    private var similarItemsCell: String = "productsSimilarItemsId"
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    private func controllerSetup() {
        configureCollectionView()
        configureRefreshControl()
        
         self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "cm_share_white"), style: .plain, target: self, action: #selector(backBtnPressed(_:)))
    }
    
    @objc private func backBtnPressed(_ sender: Any) {
        print("Hey")
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        view.addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        view.addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeHeaderCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId)
        collectionView.register(HomeFooterCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId)
        collectionView.register(RecentProductCardCollectionView.self, forCellWithReuseIdentifier: colViewContainerCell)
        collectionView.register(ProductSimilarItemsCollectionViewCell.self, forCellWithReuseIdentifier: similarItemsCell)
        collectionView.register(UINib(nibName: "CustomerHomeHeaderCell", bundle: nil), forCellWithReuseIdentifier: customerHeaderCellId)
    }
    
    private func seeMoreRecentlyViewed() {
        showHudMessage("Hello More Recently Viewed", type: .info)
    }
    
    private func productSelected(_ id: Int?) {
        let vc = viewControllerFromStoryboard(storyboard: "CustomerProducts", withIdentifier: "customerProduct") as! CustomerProductViewController
        vc.productService = self.productService
        vc.getProductDetails(id ?? 22)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func moreActionPressedInfoCard(_ id: Int) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let viewProductAction = UIAlertAction(title: "View Product", style: .default) { (action) in
            self.productSelected(id)
        }
        
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            //TODO: share product
        }
        
        let goToShop = UIAlertAction(title: "Visit Shop", style: .default) {action in
            //TODO: Visit shop
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            actionSheet.dismiss(animated: true, completion: nil)
        }
        
        actionSheet.addAction(viewProductAction)
        actionSheet.addAction(shareAction)
        actionSheet.addAction(goToShop)
        actionSheet.addAction(cancelAction)
        
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    private func configureRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        collectionView.addSubview(refreshControl)
    }

    @objc private func refresh(_ sender: Any){
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }

}


extension CustomerHomeUserController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let headerCell = collectionView.dequeueReusableCell(withReuseIdentifier: customerHeaderCellId, for: indexPath)
            return headerCell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: colViewContainerCell, for: indexPath) as! RecentProductCardCollectionView
            cell.productService = productService
            cell.retrieveData()
            cell.productSelectedAction = productSelected(_:)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: similarItemsCell, for: indexPath) as! ProductSimilarItemsCollectionViewCell
        cell.moreAction = moreActionPressedInfoCard(_:)
        cell.pressedImage = productSelected(_:)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionView.elementKindSectionFooter {
            if indexPath.section == 2 {
                let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCellId, for: indexPath) as! HomeFooterCollectionViewCell
                view.action = seeMoreRecentlyViewed
                return view
            }
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerCellId, for: indexPath) as! HomeHeaderCollectionViewCell
        
        
        if indexPath.section == 1 {
            view.title = "Recently Viewed"
            view.action = seeMoreRecentlyViewed
        }
        
        if indexPath.section == 2 {
            view.title = "Similar Items you may like"
            view.action = seeMoreRecentlyViewed
        }
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        
        if indexPath.section == 1 {
            return CGSize(width: width, height: 130)
        }
        
        if indexPath.section == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: similarItemsCell, for: indexPath) as! ProductSimilarItemsCollectionViewCell
            let height = (cell.cellHeight + cell.spacing) * CGFloat((cell.itemCount / 2))
            return CGSize(width: width, height: height)
        }
        
        return CGSize(width: width, height: 140.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = view.frame.width
        if section == 1  || section == 2 {
            return CGSize(width: width, height: 45)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        let width = view.frame.width
        if section == 2 {
            return CGSize(width: width, height: 25)
        }
        
        return CGSize(width: 0, height: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}



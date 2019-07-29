//
//  MenuBarMainController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/29/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import ChameleonFramework

class MenuBarMainController : UIViewController {
    var navTitle: String = "Menu Bar Controller" {
        didSet {
            navigationItem.title = self.navTitle
        }
    }
    @IBInspectable var menuBarHeight: Int = 50
    var viewControllers: [UIViewController] = []
    var contentController: MenuContentController?
    var menuBar: MenuBarView = {
        let mb = MenuBarView()
        return mb
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupMenuBar()
        setupContentChildViewController()
        
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.delegate = self
        menuBar.dataSource = self
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(\(menuBarHeight))]", views: menuBar)
        
        selectDefaultView()
        
    }
    
    private func selectDefaultView() {
        let indexPath = IndexPath(item: 0, section: 0)
        menuBar.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
    }
    
    private func getTitlesFromControllers() -> [String] {
        var titles = [String]()
        for vc in viewControllers {
            titles.append(vc.title ?? " ")
        }
        return titles
    }
    
    private func setupContentChildViewController() {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        view.addConstraintsWithFormat("H:|[v0]|", views: containerView)
        view.addConstraintsWithFormat("V:|-\(menuBarHeight)-[v0]|", views: containerView)
        
        let controller = MenuContentController()
        controller.viewControllers = viewControllers
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)

        containerView.addConstraintsWithFormat("H:|[v0]|", views: controller.view)
        containerView.addConstraintsWithFormat("V:|[v0]|", views: controller.view)
        contentController = controller
    }
}


//MARK:- Collection View datasource and delegate methods
extension MenuBarMainController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = menuBar.frame
        let width = frame.width / CGFloat(viewControllers.count)
        return CGSize(width: width, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension MenuBarMainController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarView.cellId, for: indexPath) as! MenuBarItemCell
        cell.item = viewControllers[indexPath.item].title ?? "Title"
        return cell
    }
    
    
}


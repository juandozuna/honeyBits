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
    @IBInspectable var menuBarHeight: Int = 30
    @IBInspectable var accentColor: UIColor = UIColor.flatYellow()
    var viewControllers: [UIViewController] = []
    var viewControllersCount: CGFloat {
        return CGFloat(viewControllers.count)
    }
    var contentController: MenuContentController?
    var menuBar: MenuBarView = {
        let mb = MenuBarView()
        return mb
    }()
    var indicatorViewLeftConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupMenuBar()
        setupContentChildViewController()
        
    }
    
    func contentViewScrolling(offset: CGFloat) {
        indicatorViewLeftConstraint?.constant = offset / viewControllersCount
    }
    
    func setActiveMenuBarItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        menuBar.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
        
        UIView.animate(withDuration: 0.6) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func setupController() {
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.delegate = self
        menuBar.dataSource = self
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:|[v0(\(menuBarHeight))]", views: menuBar)
        
        
        let horizontalView = UIView()
        horizontalView.translatesAutoresizingMaskIntoConstraints = false
        horizontalView.backgroundColor = accentColor
        view.addSubview(horizontalView)
        view.addConstraintsWithFormat("V:|-\(menuBarHeight-3)-[v0(3)]", views: horizontalView)
        
        let multiplierWidth = (1/viewControllersCount)
        
        horizontalView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplierWidth).isActive = true
        indicatorViewLeftConstraint = horizontalView.leftAnchor.constraint(equalTo: menuBar.leftAnchor, constant: 0)
        indicatorViewLeftConstraint?.isActive = true
        selectDefaultView()
        
    }
    
    private func selectDefaultView() {
        let indexPath = IndexPath(item: 0, section: 0)
        menuBar.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition(rawValue: 0))
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
        controller.parentController = self
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(controller.view)

        containerView.addConstraintsWithFormat("H:|[v0]|", views: controller.view)
        containerView.addConstraintsWithFormat("V:|[v0]|", views: controller.view)
        contentController = controller
    }
    
    private func moveIndicatorViewToSelectedItem(to index: Int) {
        contentController?.scroll(to: index)
        
    }
}


//MARK:- Collection View datasource and delegate methods
extension MenuBarMainController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let frame = menuBar.frame
        let width = frame.width / viewControllersCount
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
        cell.accentColor = accentColor
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.item
        moveIndicatorViewToSelectedItem(to: index)
    }
    
    
}


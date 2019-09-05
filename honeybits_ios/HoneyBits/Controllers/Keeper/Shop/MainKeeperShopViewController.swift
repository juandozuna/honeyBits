//
//  MainKeeperShopViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 8/18/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class MainKeeperShopViewController : UIViewController {
   
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var noShopView: KeeperNoShopView!
    @IBOutlet var bgView: UIView!
    var shopService = ShopService()
    
    var shopsTable: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.color = .flatOrange()
        aiv.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.5)
        aiv.isHidden = true
        return aiv;
    }()
    
    var shops: [ShopModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    private func setupController() {
        setupTableView()
        setupActivityIndicatorView()
        displayCorrectView()
        noShopView.setupDelegate = self
        reloadShops()
    }
    
    private func setupTableView() {
        shopsTable.register(UITableViewCell.self, forCellReuseIdentifier: "shopCell")
        
        bgView.addSubview(shopsTable)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: shopsTable)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: shopsTable)

        shopsTable.delegate = self
        shopsTable.dataSource = self
        
        
    }
    
    private func setupActivityIndicatorView() {
        bgView.addSubview(activityIndicatorView)
        bgView.addConstraintsWithFormat("H:|[v0]|", views: activityIndicatorView)
        bgView.addConstraintsWithFormat("V:|[v0]|", views: activityIndicatorView)
    }
    
    private func displayCorrectView() {
        let showShopsTable = shops.count > 0
    
        noShopView.isHidden = showShopsTable
        shopsTable.isHidden = !showShopsTable
        
    }
    
    private func getAllShops() {
        startLoading()
        shopService.getShopsForUser { (status, shops) in
            if status == .Success {
                self.shops = shops!
                self.shopsTable.reloadData()
                self.stopLoading()
            }
        }
    }
    
    private func startLoading() {
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoading() {
        displayCorrectView()
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
    private func reloadShops() {
       getAllShops()
    }
    
    private func presentShopCreationController() {
        let navController = viewControllerFromStoryboard(storyboard: "KeeperShopCreation", withIdentifier: "shopFormNav") as! UINavigationController
        let controller = navController.topViewController as! KeeperShopNameFormController
        controller.delegate = self
        present(navController, animated: true, completion: nil)
    }
    
}


extension MainKeeperShopViewController : SetupStoreDelegate {
    func setupShop() {
       presentShopCreationController()
    }
}

extension MainKeeperShopViewController : CreateShopDelegate {
    func shopCreated() {
        reloadShops()
    }
}


extension MainKeeperShopViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = shopsTable.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath)
        cell.textLabel?.text = shops[indexPath.row].shopName!
        return cell
    }
    
    
}

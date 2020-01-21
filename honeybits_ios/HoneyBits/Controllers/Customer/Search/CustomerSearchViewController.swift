//
//  CustomerSearchViewController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SVProgressHUD

class CustomerSearchViewController: UIViewController {

    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    private let productService = ProductService()
    private let tableCellIndetifier = "productTableCell"
    private var products: [ProductModel]?
    private var filteredProducts: [ProductModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controllerSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadAllProducts()
    }
    
    private func controllerSetup() {
        setupTableView()
        loadAllProducts()
        
        searchField.delegate = self
    }
    
    private func setupTableView() {
        tableView.rowHeight = 72
        tableView.separatorColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func loadAllProducts() {
        productService.getAllProducts { (status, products) in
            if status != .Success {
                SVProgressHUD.showError(withStatus: "Error retrieving Data")
                self.products = nil
                return
            }
            
            self.products = products
            self.filteredProducts = self.products
            self.tableView.reloadData()
        }
    }
    
    private func filterProducts() {
        let textToFilter = searchField.text ?? ""
        
        if textToFilter == "" {
            self.filteredProducts = products
            return
        }
        
        filteredProducts = []
        
        guard let prods = products else {
            filteredProducts = products
            return
        }
        
        for product in prods {
            if product
                .productName?
                .lowercased().contains(textToFilter.lowercased()) ?? false {
                filteredProducts?.append(product)
            }
        }
    }
}

extension CustomerSearchViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredProducts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIndetifier, for: indexPath) as! SearchProductTableCell
        
        cell.productModel = filteredProducts![indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchProductTableCell
        cell.liked = !cell.liked
    }
}

extension CustomerSearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterProducts()
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filteredProducts = products
    }
}

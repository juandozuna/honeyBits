//
//  CustomerHomeView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerHomeView: UIView {

    var delegate: LoginDelegate?
    @IBOutlet weak var tableView: UITableView!
    let shops = ["Shop 1", "Shop 2", "Shop 3"]
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        tableViewSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
        tableViewSetup()
    }
    
    
    private func tableViewSetup() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib.init(nibName: "ShopTableViewCell", bundle: nil), forCellReuseIdentifier: "shopTableCell")
    }
}


extension CustomerHomeView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.setSelected(false, animated: false)
    }

}

extension CustomerHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shopTableCell", for: indexPath) as! ShopTableViewCell
        cell.lb.text = shops[indexPath.row]
        return cell
    }
    
    
}

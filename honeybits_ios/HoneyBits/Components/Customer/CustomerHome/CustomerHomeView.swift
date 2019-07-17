//
//  CustomerHomeView.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

@IBDesignable class CustomerHomeView: UIView {

    let accountService: IAccountService = AccountService()
    var delegate: LoginDelegate?
    @IBOutlet weak var tableView: UITableView!
    let shops = ["Shop 1", "Shop 2", "Shop 3"]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
        tableView.dataSource = self
    
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    
    private func tableViewSetup() {
        
    }

    @IBAction func btnTempPressed(_ sender: Any) {
        accountService.signOut()
        delegate?.logOut()
    }
}


extension CustomerHomeView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}

extension CustomerHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ShopTableViewCell()
        
        return cell
    }
    
    
}

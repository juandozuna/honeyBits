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
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tc = UITableViewCell()
        tc.textLabel?.text = "GOOD MORNING"
        return tc
    }
    
    
}

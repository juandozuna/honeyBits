//
//  CustomerNotificationsController.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 2/10/20.
//  Copyright © 2020 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit

class CustomerNotificationsController : UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight =  128
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension CustomerNotificationsController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    
    
}

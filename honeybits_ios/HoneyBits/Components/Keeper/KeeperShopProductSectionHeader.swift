//
//  KeeperShopProductSectionHeader.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 9/11/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import RxSwift

class KeeperShopProductSectionHeader: UICollectionReusableView {
    
    private let addBtnSubject = BehaviorSubject<Void>(value: ())
    
    var addBtnObservable: Observable<Void> {
        return addBtnSubject.asObservable()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        //addBtnSubject.onNext(())
    }
    
    
}

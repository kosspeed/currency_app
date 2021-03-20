//
//  SelectCurrencyButton.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//

import UIKit

typealias SelectedCurrency = (CurrencyDetail, RateDetail)

class SelectCurrencyButton: UIButton {
    var didSeleted: Delegated<SelectedCurrency>
    
    required init?(coder: NSCoder) {
        didSeleted = Delegated<SelectedCurrency>()
        super.init(coder: coder)
    }
}

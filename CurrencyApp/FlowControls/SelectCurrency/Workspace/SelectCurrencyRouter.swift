//
//  SelectCurrencyRouter.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SelectCurrencyRouter: SelectCurrencyDataPassing {
    private weak var viewController: SelectCurrencyViewController?
    var dataStore: SelectCurrencyDataStore?
    
    init(viewController: SelectCurrencyViewController) {
        self.viewController = viewController
    }
}

//MARK: Routable
extension SelectCurrencyRouter: SelectCurrencyRoutable {
    func routeBack() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func execute(currency: CurrencyDetail, rate: RateDetail) {
        guard let mode = dataStore?.mode else { return }
        
        switch mode {
        case .fromButton(let button):
            button.didSeleted.callback?((currency, rate))
        case .manual:
            dataStore?.executed?(currency, rate)
        }
    }
}

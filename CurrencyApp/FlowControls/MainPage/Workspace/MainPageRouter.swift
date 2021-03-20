//
//  MainPageRouter.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainPageRouter:  MainPageDataPassing {
    private weak var viewController: MainPageViewController?
    var dataStore: MainPageDataStore?
    
    init(viewController: MainPageViewController) {
        self.viewController = viewController
    }
}

//MARK: Routable
extension MainPageRouter: MainPageRoutable {
    func routeToCurrencySelection(mode: SelectCurrencyMode) {
        let destination = SelectCurrencyViewController.make()
        destination.router.dataStore?.mode = mode
        destination.router.dataStore?.currencies = dataStore?.currency?.details
        destination.router.dataStore?.rates = dataStore?.rate?.details
        
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
}

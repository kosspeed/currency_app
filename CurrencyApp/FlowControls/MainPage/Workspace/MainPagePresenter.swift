//
//  MainPagePresenter.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainPagePresenter {
    private weak var displayable: MainPageDisplayable?
    
    init(displayable: MainPageDisplayable) {
        self.displayable = displayable
    }
}

//MARK: Presentable
extension MainPagePresenter: MainPagePresentable {
    func presentGetCurrencies(response: MainPage.GetCurrencies.Response) {
        let topCard = buildCurrencyCard(with: response.top)
        let bottomCard = buildCurrencyCard(with: response.bottom)
        
        displayable?.displayGetCurrencies(viewModel: .init(top: topCard,
                                                           bottom: bottomCard))
    }
    
    func presentGetRates(response: MainPage.GetRates.Response) {
        displayable?.displayGetRates(viewModel: .init())
    }
    
    func presentGetConversion(response: MainPage.GetConversion.Response) {
        var amount = response.result
        let roundedAmount = amount.roundToPlaces(places: 2)
        let formattedAmount = roundedAmount.commas
        
        displayable?.displayGetConversion(viewModel: .init(amount: formattedAmount))
    }
    
    func presentSwitchCurrency(response: MainPage.SwitchCurrency.Response) {
        let topCard = buildCurrencyCard(with: response.top)
        let bottomCard = buildCurrencyCard(with: response.bottom)
        
        displayable?.displaySwitchCurrency(viewModel: .init(top: topCard,
                                                            bottom: bottomCard))
    }
    
    func presentSetCurrency(response: MainPage.SetCurrency.Response) {
        let topCard = buildCurrencyCard(with: response.top)
        let bottomCard = buildCurrencyCard(with: response.bottom)
        
        displayable?.displaySetCurrency(viewModel: .init(top: topCard,
                                                         bottom: bottomCard))
    }
    
    func presentSetToken(response: MainPage.SetToken.Response) {
        displayable?.displaySetToken(viewModel: .init())
    }
    
    func presentError(response: MainPage.Error.Response) {
        if let error = response.error {
            let code = error.detail.code.description
            let message = error.detail.message + "\n" + "code: " + code
            let type: MainPage.ErrorType = code == 9999.description ? .insertToken : .default
            
            displayable?.displayError(viewModel: .init(code: code,
                                                       message: message,
                                                       type: type))
        }
    }
    
    private func buildCurrencyCard(with currency: CurrencyDetail?) -> MainPage.CurrencyCard {
        return MainPage.CurrencyCard(symbol: currency?.symbol ?? "N/A",
                                     code: currency?.name,
                                     name: currency?.value,
                                     amount: 0.0.description)
    }
}

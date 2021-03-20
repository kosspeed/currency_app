//
//  SelectCurrencyPresenter.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SelectCurrencyPresenter {
    private weak var displayable: SelectCurrencyDisplayable?
    
    init(displayable: SelectCurrencyDisplayable) {
        self.displayable = displayable
    }
}

//MARK: Presentable
extension SelectCurrencyPresenter: SelectCurrencyPresentable {
    func presentGetCurrencies(response: SelectCurrency.GetCurrencies.Response) {
        let currencies = buildCurrencies(currencies: response.currencies,
                                         rates: response.rates)
        
        displayable?.displayCurrencies(viewModel: .init(currencies: currencies))
    }
    
    func presentSetSearchState(response: SelectCurrency.SetSearchState.Response) {
        displayable?.displaySetSearchState(viewModel: .init())
    }
    
    func presentSearch(response: SelectCurrency.Search.Response) {
        let currencies = buildCurrencies(currencies: response.currencies,
                                         rates: response.rates)
        
        displayable?.displaySearch(viewModel: .init(currencies: currencies))
    }
    
    func presentQueryCurrencyToExecute(response: SelectCurrency.QueryCurrencyToExecute.Response) {
        displayable?.displayQueryCurrencyToExecute(viewModel: .init(currency: response.currency,
                                                                    rate: response.rate))
    }
    
    private func buildCurrencies(currencies: [CurrencyDetail]?, rates: [RateDetail]?) -> [SelectCurrency.Currency] {
        return currencies?.map { (currency) in
            var rate = rates?
                .filter { $0.name == currency.name }
                .first?
                .value ?? 0.0
            let formattedRate = rate.roundToPlaces(places: 2).commas
            
            let emojiNotNil = currency.emoji != nil
            let symbolNotNil = currency.symbol != nil
            
            return SelectCurrency.Currency(flag: emojiNotNil ? currency.emoji : "N/A",
                                           flagFontSize: emojiNotNil ? 35 : 20,
                                           code: currency.name,
                                           name: currency.value,
                                           symbol: symbolNotNil ? currency.symbol : "N/A",
                                           rate: formattedRate)
            
        } ?? []
    }
}

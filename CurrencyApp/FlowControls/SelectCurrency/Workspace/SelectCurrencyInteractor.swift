//
//  SelectCurrencyInteractor.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class SelectCurrencyInteractor: SelectCurrencyDataStore {
    var mode: SelectCurrencyMode
    var searching: Bool
    var currencies: [CurrencyDetail]?
    var filteredCurrencies: [CurrencyDetail]?
    var rates: [RateDetail]?
    var filteredRates: [RateDetail]?
    
    var executed: ((_ currency: CurrencyDetail, _ rate: RateDetail) -> Void)?
    
    var presenter: SelectCurrencyPresentable
    
    init(presenter: SelectCurrencyPresentable) {
        self.presenter = presenter
        mode = .manual
        searching = false
    }
}

//MARK: BusinessLogic
extension SelectCurrencyInteractor: SelectCurrencyBusinessLogic {
    func getCurrencies(request: SelectCurrency.GetCurrencies.Request) {
        let currencies = searching ? filteredCurrencies : self.currencies
        let rates = searching ? filteredRates : self.rates
        
        presenter.presentGetCurrencies(response: .init(currencies: currencies,
                                                       rates: rates))
    }
    
    func setSearchState(request: SelectCurrency.SetSearchState.Request) {
        searching = request.searching
        
        if !searching {
            filteredCurrencies = nil
            filteredRates = nil
        }
        
        presenter.presentSetSearchState(response: .init())
    }
    
    func search(request: SelectCurrency.Search.Request) {
        let spaceStrippedSearchText = request.text.trimmingCharacters(in: .whitespaces).lowercased()
        
        guard !spaceStrippedSearchText.isEmpty else {
            presenter.presentSearch(response: .init(currencies: currencies,
                                                    rates: rates))
            return
        }
        
        filteredCurrencies = currencies?.filter { $0.name.lowercased().contains(spaceStrippedSearchText) || $0.value.lowercased().contains(spaceStrippedSearchText) }
        
        if filteredRates == nil {
            filteredRates = [RateDetail]()
        }
        
        filteredCurrencies?.forEach { (currency) in
            if let filteredRate = rates?.filter({ $0.name == currency.name }).first {
                filteredRates?.append(filteredRate)
            }
        }
        
        presenter.presentSearch(response: .init(currencies: filteredCurrencies,
                                                rates: filteredRates))
    }
    
    func queryCurrencyToExecute(request: SelectCurrency.QueryCurrencyToExecute.Request) {
        let currency = currencies?
            .filter({ $0.name == request.code })
            .first ?? .init(name: "",
                            value: "",
                            symbol: nil,
                            emoji: nil)
        
        let rate = rates?
            .filter { $0.name == request.code }
            .first ?? .init(name: "", value: 0)
        
        presenter.presentQueryCurrencyToExecute(response: .init(currency: currency,
                                                                rate: rate))
    }
}

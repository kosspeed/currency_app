//
//  SelectCurrencyProtocols.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol SelectCurrencyDisplayable: class {
    func displayGetCurrencies(viewModel: SelectCurrency.GetCurrencies.ViewModel)
    func displaySetSearchState(viewModel: SelectCurrency.SetSearchState.ViewModel)
    func displaySearch(viewModel: SelectCurrency.Search.ViewModel)
    func displayQueryCurrencyToExecute(viewModel: SelectCurrency.QueryCurrencyToExecute.ViewModel)
}

//MARK: Interactor
protocol SelectCurrencyBusinessLogic {
    func getCurrencies(request: SelectCurrency.GetCurrencies.Request)
    func setSearchState(request: SelectCurrency.SetSearchState.Request)
    func search(request: SelectCurrency.Search.Request)
    func queryCurrencyToExecute(request: SelectCurrency.QueryCurrencyToExecute.Request)
}

//MARK: Presenter
protocol SelectCurrencyPresentable {
    func presentGetCurrencies(response: SelectCurrency.GetCurrencies.Response)
    func presentSetSearchState(response: SelectCurrency.SetSearchState.Response)
    func presentSearch(response: SelectCurrency.Search.Response)
    func presentQueryCurrencyToExecute(response: SelectCurrency.QueryCurrencyToExecute.Response)
}

//MARK: Routable
protocol SelectCurrencyRoutable {
    func routeBack()
    func execute(currency: CurrencyDetail, rate: RateDetail)
}

//MARK: DataStore
protocol SelectCurrencyDataStore {
    var mode: SelectCurrencyMode { get set }
    var searching: Bool { get set }
    var currencies: [CurrencyDetail]? { get set }
    var filteredCurrencies: [CurrencyDetail]? { get set }
    var rates: [RateDetail]? { get set }
    var filteredRates: [RateDetail]? { get set }
    var executed: ((_ currency: CurrencyDetail, _ rate: RateDetail) -> Void)? { get set }
}

//MARK: DataPassing
protocol SelectCurrencyDataPassing {
    var dataStore: SelectCurrencyDataStore? { get set }
}

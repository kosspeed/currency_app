//
//  MainPageProtocols.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

//MARK: ViewController
protocol MainPageDisplayable: class {
    func displayGetCurrencies(viewModel: MainPage.GetCurrencies.ViewModel)
    func displayGetRates(viewModel: MainPage.GetRates.ViewModel)
    func displayGetConversion(viewModel: MainPage.GetConversion.ViewModel)
    func displaySwitchCurrency(viewModel: MainPage.SwitchCurrency.ViewModel)
    func displayError(viewModel: MainPage.Error.ViewModel)
}

//MARK: Interactor
protocol MainPageBusinessLogic {
    func getCurrencies(request: MainPage.GetCurrencies.Request)
    func getRates(request: MainPage.GetRates.Request)
    func getConversion(request: MainPage.GetConversion.Request)
    func switchCurrency(request: MainPage.SwitchCurrency.Request)
}

//MARK: Presenter
protocol MainPagePresentable {
    func presentGetCurrencies(response: MainPage.GetCurrencies.Response)
    func presentGetRates(response: MainPage.GetRates.Response)
    func presentGetConversion(response: MainPage.GetConversion.Response)
    func presentSwitchCurrency(response: MainPage.SwitchCurrency.Response)
    func presentError(response: MainPage.Error.Response)
}

//MARK: Routable
protocol MainPageRoutable {
    func routeToCurrencySelection()
}

//MARK: DataStore
protocol MainPageDataStore {
    var topCurrency: CurrencyDetail? { get set }
    var bottomCurrency: CurrencyDetail? { get set }
    var currency: Currency? { get set }
    
    var topRate: RateDetail? { get set }
    var bottomRate: RateDetail? { get set }
    var rate: Rate? { get set }
}

//MARK: DataPassing
protocol MainPageDataPassing {
    var dataStore: MainPageDataStore? { get set }
}

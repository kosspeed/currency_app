//
//  MainPageInteractor.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

class MainPageInteractor: MainPageDataStore {
    var presenter: MainPagePresentable
    
    var topCurrency: CurrencyDetail?
    var bottomCurrency: CurrencyDetail?
    var currency: Currency?
    
    var topRate: RateDetail?
    var bottomRate: RateDetail?
    var rate: Rate?
    
    private var getCurrenciesUseCase: GetCurrenciesUseCase
    private var getRatesUseCase: GetRatesUseCase
    private var getConversionUseCase: GetConversionUseCase
    
    init(presenter: MainPagePresentable,
         getCurrenciesUseCase: GetCurrenciesUseCase = GetCurrenciesUseCaseImpl(),
         getRatesUseCase: GetRatesUseCase = GetRatesUseCaseImpl(),
         getConversionUseCase: GetConversionUseCase = GetConversionUseCaseImpl()) {
        self.presenter = presenter
        self.getCurrenciesUseCase = getCurrenciesUseCase
        self.getRatesUseCase = getRatesUseCase
        self.getConversionUseCase = getConversionUseCase
    }
}

//MARK: BusinessLogic
extension MainPageInteractor: MainPageBusinessLogic {
    func getCurrencies(request: MainPage.GetCurrencies.Request) {
        getCurrenciesUseCase.execute(completion: { [weak self] (currency) in
            self?.topCurrency = currency.details.first(where: { $0.name == "USD" })
            self?.bottomCurrency = currency.details.first(where: { $0.name == "THB" })
            self?.currency = currency
            
            self?.presenter.presentGetCurrencies(response: .init(top: self?.topCurrency,
                                                                bottom: self?.bottomCurrency))
        }, failure: { [weak self] (error) in
            self?.presenter.presentError(response: .init(error: error))
        })
    }
    
    func getRates(request: MainPage.GetRates.Request) {
        getRatesUseCase.execute(completion: { [weak self] (rate) in
            self?.topRate = rate.details.first(where: { $0.name == self?.topCurrency?.name })
            self?.bottomRate = rate.details.first(where: { $0.name == self?.bottomCurrency?.name })
            self?.rate = rate
            
            self?.presenter.presentGetRates(response: .init())
        }, failure: { [weak self] (error) in
            self?.presenter.presentError(response: .init(error: error))
        })
    }
    
    func getConversion(request: MainPage.GetConversion.Request) {
        guard let topRate = topRate,
              let bottomRate = bottomRate else { return }
        
        let amount = Double(request.amount) ?? 0
        
        getConversionUseCase.execute(from: topRate, to: bottomRate, amount: amount, completion: { [weak self] (conversion) in
            self?.presenter.presentGetConversion(response: .init(result: conversion.result))
        }, failure: { [weak self] (error) in
            self?.presenter.presentError(response: .init(error: error))
        })
    }
    
    func switchCurrency(request: MainPage.SwitchCurrency.Request) {
        let templateRate = topRate
        let templateCurrency = topCurrency
        
        /* Swap Rate */
        topRate = bottomRate
        bottomRate = templateRate
        
        /* Swap Currency */
        topCurrency = bottomCurrency
        bottomCurrency = templateCurrency
        
        presenter.presentSwitchCurrency(response: .init(top: topCurrency,
                                                        bottom: bottomCurrency))
    }
    
    func setCurrency(request: MainPage.SetCurrency.Request) {
        switch request.mode {
        case .top(let currency, let rate):
            topCurrency = currency
            topRate = rate
        case .bottom(let currency, let rate):
            bottomCurrency = currency
            bottomRate = rate
        }
        
        presenter.presentSetCurrency(response: .init(top: topCurrency,
                                                     bottom: bottomCurrency))
    }
    
    func setToken(request: MainPage.SetToken.Request) {
        Config.default.setRuntimeToken(token: request.token)
    
        presenter.presentSetToken(response: .init())
    }
}

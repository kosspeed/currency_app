//
//  GetCurrenciesUseCase.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

fileprivate let kCurrenciesInfoJSON: String = "currencies"

protocol GetCurrenciesUseCase {
    func execute(completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class GetCurrenciesUseCaseImpl: GetCurrenciesUseCase {
    private let repository: CurrencyRepository
    private let bundle: Bundle
    private var currenciesInfo: [[String: Any]]?
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl(), bundle: Bundle = .main) {
        self.repository = repository
        self.bundle = bundle
        currenciesInfo = getCurrenciesInfo(fileName: kCurrenciesInfoJSON)
    }
    
    func execute(completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void) {
        let request = GetCurrenciesRequest()
        repository.getCurrencies(request: request, completion: { [weak self] (currency) in
            guard let self = self else { return }
            
            var currency = currency
            
            for (index, value) in currency.details.enumerated() {
                let additionalsInfo = self.getAdditionalsInfo(currencyCode: value.name)
                currency.details[index].symbol = additionalsInfo.symbol
                currency.details[index].emoji = additionalsInfo.emoji
            }
            
            completion(currency)
            
        }, failure: failure)
    }
    
    private func getCurrenciesInfo(fileName: String) -> [[String: Any]]? {
        return JSONUtils.loadJson(bundle: bundle, name: fileName)
    }
    
    private func getAdditionalsInfo(currencyCode: String) -> (symbol: String?, emoji: String?) {
        return currenciesInfo?.filter {
            ($0["code"] as? String) == currencyCode
        }
        .compactMap {
            (symbol: $0["symbol"] as? String,
             emoji: $0["emoji"] as? String)
        }
        .first ?? (symbol: nil, emoji: nil)
    }
}

//
//  CurrencyRemoteDataSource.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation
import Moya

protocol CurrencyRemoteDataSource {
    func getCurrencies(request: GetCurrenciesRequest, completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void)
    func getRates(request: GetRatesRequest, completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void)
    func getConversion(request: GetConversionRequest, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class CurrencyRemoteDataSourceImpl: CurrencyRemoteDataSource {
    private let provider: MoyaProvider<CurrencyAPI>
    
    init() {
        provider = MoyaProvider<CurrencyAPI>()
    }
    
    func getCurrencies(request: GetCurrenciesRequest, completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void) {
        provider.requestWithWrappedSerialize(.getCurrencies(request: request), resposeType: GetCurrenciesResponse.self) { (result) in
            switch result {
            case .success(let response):
                completion(response.entity)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getRates(request: GetRatesRequest, completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void) {
        provider.requestWithWrappedSerialize(.getRates(request: request), resposeType: GetRatesResponse.self) { (result) in
            switch result {
            case .success(let response):
                completion(response.entity)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getConversion(request: GetConversionRequest, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void) {
        provider.requestWithWrappedSerialize(.getConversion(request: request), resposeType: GetConversionResponse.self) { (result) in
            switch result {
            case .success(let response):
                completion(response.entity)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

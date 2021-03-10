//
//  CurrencyRepository.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation
import Moya

protocol CurrencyRepository {
    func getCurrencies(request: GetCurrenciesRequest, completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void)
    func getRates(request: GetRatesRequest, completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void)
    func getConversion(request: GetConversionRequest, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class CurrencyRepositoryImpl: CurrencyRepository {
    private let remoteDataSource: CurrencyRemoteDataSource
    
    init(remoteDataSource: CurrencyRemoteDataSource = CurrencyRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCurrencies(request: GetCurrenciesRequest, completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void) {
        remoteDataSource.getCurrencies(request: request, completion: completion, failure: failure)
    }
    
    func getRates(request: GetRatesRequest, completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void) {
        remoteDataSource.getRates(request: request, completion: completion, failure: failure)
    }
    
    func getConversion(request: GetConversionRequest, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void) {
        remoteDataSource.getConversion(request: request, completion: completion, failure: failure)
    }
}

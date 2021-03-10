//
//  GetCurrenciesUseCase.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

protocol GetCurrenciesUseCase {
    func execute(completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class GetCurrenciesUseCaseImpl: GetCurrenciesUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void) {
        let request = GetCurrenciesRequest()
        repository.getCurrencies(request: request, completion: completion, failure: failure)
    }
}

//
//  GetRatesUseCase.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

protocol GetRatesUseCase {
    func execute(completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class GetRatesUseCaseImpl: GetRatesUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void) {
        let request = GetRatesRequest()
        repository.getRates(request: request, completion: completion, failure: failure)
    }
}

//
//  GetCoversionUseCase.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

protocol GetCoversionUseCase {
    func execute(from: String, to: String, amount: Double, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class GetCoversionUseCaseImpl: GetCoversionUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(from: String, to: String, amount: Double, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void) {
        let request = GetConversionRequest(from: from, to: to, amount: amount)
        repository.getConversion(request: request, completion: completion, failure: failure)
    }
}

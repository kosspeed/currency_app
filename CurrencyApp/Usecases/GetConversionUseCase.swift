//
//  GetCoversionUseCase.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

protocol GetConversionUseCase {
    func execute(from: RateDetail, to: RateDetail, amount: Double, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void)
}

class GetConversionUseCaseImpl: GetConversionUseCase {
    private let repository: CurrencyRepository
    
    init(repository: CurrencyRepository = CurrencyRepositoryImpl()) {
        self.repository = repository
    }
    
    func execute(from: RateDetail, to: RateDetail, amount: Double, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void) {
        let request = GetConversionRequest(from: from.name, to: to.name, amount: amount)
        repository.getConversion(request: request, completion: { (conversion) in
            if conversion.valid {
                completion(conversion)
            } else {
                let detail = CurrencyErrorDetail(code: 9999, message: "Something went wrong!. \nYou can retry by using paid subscription token.")
                let error = CurrencyError(detail: detail)
                
                failure(error)
            }
        }, failure: failure)
    }
}

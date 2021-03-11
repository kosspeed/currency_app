//
//  MockGetRatesUseCase.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

class MockGetRatesUseCaseImpl: GetRatesUseCaseImpl {
    enum Result {
        case success
        case failure
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    override func execute(completion: @escaping (Rate) -> Void, failure: @escaping (CurrencyError) -> Void) {
        switch result {
        case .success:
            completion(MockCurrencyResponseFactory.ratesResponse.entity)
        case .failure:
            failure(MockCurrencyErrorResponseFactory.customErrorResponse().entity)
        }
    }
}

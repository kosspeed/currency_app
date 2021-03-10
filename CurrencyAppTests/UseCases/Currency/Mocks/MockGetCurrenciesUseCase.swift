//
//  MockGetCurrenciesUseCase.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

class MockGetCurrenciesUseCaseImpl: GetCurrenciesUseCaseImpl {
    enum Result {
        case success
        case failure
        case failure400
        case failure401
        case failure416
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    override func execute(completion: @escaping (Currency) -> Void, failure: @escaping (CurrencyError) -> Void) {
        switch result {
        case .success:
            completion(MockCurrencyResponseFactory.currenciesResponse.entity)
        case .failure:
            failure(MockCurrencyErrorResponseFactory.customErrorResponse().entity)
        case .failure400:
            failure(MockCurrencyResponseFactory.failure400Response.entity)
        case .failure401:
            failure(MockCurrencyResponseFactory.failure401Response.entity)
        case .failure416:
            failure(MockCurrencyResponseFactory.failure416Response.entity)
        }
    }
}

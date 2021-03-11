//
//  MockGetConversionUseCase.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

class MockGetConversionUseCaseImpl: GetConversionUseCaseImpl {
    enum Result {
        case success
        case failure
    }
    
    private let result: Result
    
    init(result: Result) {
        self.result = result
    }
    
    override func execute(from: String, to: String, amount: Double, completion: @escaping (Conversion) -> Void, failure: @escaping (CurrencyError) -> Void) {
        switch result {
        case .success:
            completion(MockCurrencyResponseFactory.conversionResponse.entity)
        case .failure:
            failure(MockCurrencyErrorResponseFactory.customErrorResponse().entity)
        }
    }
}

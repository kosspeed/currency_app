//
//  GetConversionUseCaseTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class GetConversionUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .success)
        let useCase = GetConversionUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(from: .init(name: "THB", value: 0), to: .init(name: "USD", value: 0), amount: 1.234, completion: { (conversion) in
            /*
             from = "THB"
             to = "USD",
             amount = 1.234
             result = 41.956
             */
            
            //assert
            XCTAssertEqual(conversion.from, "THB")
            XCTAssertEqual(conversion.to, "USD")
            XCTAssertEqual(conversion.amount, 1.234)
            XCTAssertEqual(conversion.result, 41.956)
            
        }, failure: { (error) in
            
        })
    }
    
    func test_executeFailure() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure)
        let useCase = GetConversionUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(from: .init(name: "", value: 0), to: .init(name: "", value: 0), amount: 0, completion: { (conversion) in
           
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
    
    func test_executeFailure416() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure416)
        let useCase = GetConversionUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(from: .init(name: "", value: 0), to: .init(name: "", value: 0), amount: 0, completion: { (conversion) in
           
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 416)
            XCTAssertEqual(error.detail.message, "Your subscription plan does not allow you to use the %s endpoint")
        })
    }
}

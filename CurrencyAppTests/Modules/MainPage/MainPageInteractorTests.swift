//
//  MainPageInteractorTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class MainPageInteractorTests: XCTestCase {
    
    var sut: MainPageInteractor!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getCurrenciesSuccess() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetCurrenciesUseCaseImpl(result: .success)
        
        sut = MainPageInteractor(presenter: presenterSpy, getCurrenciesUseCase: useCase)
        
        sut.getCurrencies(request: .init())
        
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.top)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.bottom)
        XCTAssert(presenterSpy.presentGetCurrenciesCalled)
    }
    
    func test_getCurrenciesFailure() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetCurrenciesUseCaseImpl(result: .failure)
        
        sut = MainPageInteractor(presenter: presenterSpy, getCurrenciesUseCase: useCase)
        
        sut.getCurrencies(request: .init())
        
        XCTAssertNil(presenterSpy.getCurrenciesResponse)
        XCTAssertNil(presenterSpy.getCurrenciesResponse?.top)
        XCTAssertNil(presenterSpy.getCurrenciesResponse?.bottom)
        XCTAssert(presenterSpy.presentErrorCalled)
    }
    
    func test_getRatesSuccess() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetRatesUseCaseImpl(result: .success)
        
        sut = MainPageInteractor(presenter: presenterSpy, getRatesUseCase: useCase)
        
        sut.getRates(request: .init())
        
        XCTAssertNotNil(presenterSpy.getRatesResponse)
        XCTAssert(presenterSpy.presentGetRatesCalled)
    }
    
    func test_getRatesFailure() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetRatesUseCaseImpl(result: .failure)
        
        sut = MainPageInteractor(presenter: presenterSpy, getRatesUseCase: useCase)
        
        sut.getRates(request: .init())
        
        XCTAssertNil(presenterSpy.getRatesResponse)
        XCTAssert(presenterSpy.presentErrorCalled)
    }
    
    func test_getConversionSuccess() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetConversionUseCaseImpl(result: .success)
        
        sut = MainPageInteractor(presenter: presenterSpy, getConversionUseCase: useCase)
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.topRate = rateDetails[0]
        sut.bottomRate = rateDetails[1]
        
        sut.getConversion(request: .init(amount: ""))
        
        XCTAssertNotNil(presenterSpy.getConversionResponse)
        XCTAssertNotNil(presenterSpy.getConversionResponse?.result)
        XCTAssert(presenterSpy.presentGetConversionCalled)
    }
    
    func test_getConversionFailure() {
        let presenterSpy = MainPagePresenterSpy()
        let useCase = MockGetConversionUseCaseImpl(result: .failure)
        
        sut = MainPageInteractor(presenter: presenterSpy, getConversionUseCase: useCase)
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.topRate = rateDetails[0]
        sut.bottomRate = rateDetails[1]
        
        sut.getConversion(request: .init(amount: ""))
        
        XCTAssertNil(presenterSpy.getConversionResponse)
        XCTAssert(presenterSpy.presentErrorCalled)
    }
    
    func test_getConversionRateIsNil() {
        let presenterSpy = MainPagePresenterSpy()
        sut = MainPageInteractor(presenter: presenterSpy)
        
        sut.getConversion(request: .init(amount: ""))
        
        XCTAssertNil(presenterSpy.getConversionResponse)
    }
    
    func test_switchCurrency() {
        let presenterSpy = MainPagePresenterSpy()
        
        sut = MainPageInteractor(presenter: presenterSpy)
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.topCurrency = currencyDetails[0]
        sut.bottomCurrency = currencyDetails[1]
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.topRate = rateDetails[0]
        sut.bottomRate = rateDetails[1]
        
        sut.switchCurrency(request: .init())
        
        XCTAssertNotNil(presenterSpy.switchCurrencyResponse)
        XCTAssertNotNil(presenterSpy.switchCurrencyResponse?.top)
        XCTAssertNotNil(presenterSpy.switchCurrencyResponse?.bottom)
        XCTAssert(presenterSpy.presentSwitchCurrencyCalled)
    }
}

//Spy
extension MainPageInteractorTests {
    class MainPagePresenterSpy: MainPagePresentable {
        var presentGetCurrenciesCalled = false
        var presentGetRatesCalled = false
        var presentGetConversionCalled = false
        var presentSwitchCurrencyCalled = false
        var presentErrorCalled = false
        
        var getCurrenciesResponse: MainPage.GetCurrencies.Response?
        var getRatesResponse: MainPage.GetRates.Response?
        var getConversionResponse: MainPage.GetConversion.Response?
        var switchCurrencyResponse: MainPage.SwitchCurrency.Response?
        var errorResponse: MainPage.Error.Response?
        
        func presentGetCurrencies(response: MainPage.GetCurrencies.Response) {
            presentGetCurrenciesCalled = true
            getCurrenciesResponse = response
        }
        
        func presentGetRates(response: MainPage.GetRates.Response) {
            presentGetRatesCalled = true
            getRatesResponse = response
        }
        
        func presentGetConversion(response: MainPage.GetConversion.Response) {
            presentGetConversionCalled = true
            getConversionResponse = response
        }
        
        func presentSwitchCurrency(response: MainPage.SwitchCurrency.Response) {
            presentSwitchCurrencyCalled = true
            switchCurrencyResponse = response
        }
        
        func presentError(response: MainPage.Error.Response) {
            presentErrorCalled = true
            errorResponse = response
        }
    }
}

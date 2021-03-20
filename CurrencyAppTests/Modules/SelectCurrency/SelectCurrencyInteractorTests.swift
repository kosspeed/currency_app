//
//  SelectCurrencyInteractorTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class SelectCurrencyInteractorTests: XCTestCase {
    
    var sut: SelectCurrencyInteractor!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_getCurrenciesCaseNormally() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        sut.searching = false
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.currencies = currencyDetails
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.rates = rateDetails
        
        sut.getCurrencies(request: .init())
        
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.currencies)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.rates)
        XCTAssert(presenterSpy.presentGetCurrenciesCalled)
    }
    
    func test_getCurrenciesCaseSearch() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        sut.searching = true
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.filteredCurrencies = currencyDetails
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.filteredRates = rateDetails
        
        sut.getCurrencies(request: .init())
        
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.currencies)
        XCTAssertNotNil(presenterSpy.getCurrenciesResponse?.rates)
        XCTAssert(presenterSpy.presentGetCurrenciesCalled)
    }
    
    func test_setSearchStateTrue() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        sut.setSearchState(request: .init(searching: true))
        
        XCTAssertNotNil(presenterSpy.setSearchStateResponse)
        XCTAssert(presenterSpy.presentSetSearchStateCalled)
    }
    
    func test_setSearchStateFalse() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        sut.setSearchState(request: .init(searching: false))
        
        XCTAssertNotNil(presenterSpy.setSearchStateResponse)
        XCTAssert(presenterSpy.presentSetSearchStateCalled)
    }
    
    func test_searchHasText() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.currencies = currencyDetails
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.rates = rateDetails
        
        sut.search(request: .init(text: "USD"))
        
        XCTAssertNotNil(presenterSpy.searchResponse)
        XCTAssertNotNil(presenterSpy.searchResponse?.currencies)
        XCTAssertNotNil(presenterSpy.searchResponse?.rates)
        XCTAssert(presenterSpy.presentSearchCalled)
    }
    
    func test_searchHasntText() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.currencies = currencyDetails
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.rates = rateDetails
        
        sut.search(request: .init(text: ""))
        
        XCTAssertNotNil(presenterSpy.searchResponse)
        XCTAssertNotNil(presenterSpy.searchResponse?.currencies)
        XCTAssertNotNil(presenterSpy.searchResponse?.rates)
        XCTAssert(presenterSpy.presentSearchCalled)
    }
    
    func test_queryCurrencyToExecuteCaseHaveData() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        /* Currencies */
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        sut.currencies = currencyDetails
        
        /* Rates */
        let rateDetails = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.rates = rateDetails
        
        sut.queryCurrencyToExecute(request: .init(code: "USD"))
        
        XCTAssertNotNil(presenterSpy.queryCurrencyToExecuteResponse)
        XCTAssertNotNil(presenterSpy.queryCurrencyToExecuteResponse?.currency)
        XCTAssertNotNil(presenterSpy.queryCurrencyToExecuteResponse?.rate)
        XCTAssert(presenterSpy.presentQueryCurrencyToExecuteCalled)
    }
    
    func test_queryCurrencyToExecuteCaseHaventData() {
        let presenterSpy = SelectCurrencyPresenterSpy()
        
        sut = SelectCurrencyInteractor(presenter: presenterSpy)
        
        sut.queryCurrencyToExecute(request: .init(code: "USD"))
        
        XCTAssertNotNil(presenterSpy.queryCurrencyToExecuteResponse)
        XCTAssertEqual(presenterSpy.queryCurrencyToExecuteResponse?.currency.name, "")
        XCTAssertEqual(presenterSpy.queryCurrencyToExecuteResponse?.rate.name, "")
        XCTAssert(presenterSpy.presentQueryCurrencyToExecuteCalled)
    }
}

//Spy
extension SelectCurrencyInteractorTests {
    class SelectCurrencyPresenterSpy: SelectCurrencyPresentable {
        var presentGetCurrenciesCalled = false
        var presentSetSearchStateCalled = false
        var presentSearchCalled = false
        var presentQueryCurrencyToExecuteCalled = false
        
        var getCurrenciesResponse: SelectCurrency.GetCurrencies.Response?
        var setSearchStateResponse: SelectCurrency.SetSearchState.Response?
        var searchResponse: SelectCurrency.Search.Response?
        var queryCurrencyToExecuteResponse: SelectCurrency.QueryCurrencyToExecute.Response?
        
        func presentGetCurrencies(response: SelectCurrency.GetCurrencies.Response) {
            presentGetCurrenciesCalled = true
            getCurrenciesResponse = response
        }
        
        func presentSetSearchState(response: SelectCurrency.SetSearchState.Response) {
            presentSetSearchStateCalled = true
            setSearchStateResponse = response
        }
        
        func presentSearch(response: SelectCurrency.Search.Response) {
            presentSearchCalled = true
            searchResponse = response
        }
        
        func presentQueryCurrencyToExecute(response: SelectCurrency.QueryCurrencyToExecute.Response) {
            presentQueryCurrencyToExecuteCalled = true
            queryCurrencyToExecuteResponse = response
        }
    }
}

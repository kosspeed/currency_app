//
//  MainPage.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

struct MainPage {
    
    //MARK: Use Cases
    struct GetCurrencies {
        struct Request {
            
        }
        
        struct Response {
            var top: CurrencyDetail?
            var bottom: CurrencyDetail?
        }
        
        struct ViewModel {
            var top: CurrencyCard
            var bottom: CurrencyCard
        }
    }
    
    struct GetRates {
        struct Request {
            
        }
        
        struct Response {
            
        }
        
        struct ViewModel {
            
        }
    }
    
    struct GetConversion {
        struct Request {
            var amount: String
        }
        
        struct Response {
            var result: Double
        }
        
        struct ViewModel {
            var amount: String
        }
    }
    
    struct SwitchCurrency {
        struct Request {
        }
        
        struct Response {
            var top: CurrencyDetail?
            var bottom: CurrencyDetail?
        }
        
        struct ViewModel {
            var top: CurrencyCard
            var bottom: CurrencyCard
        }
    }
    
    struct Error {
        struct Request {
            
        }
        
        struct Response {
            var error: CurrencyError?
        }
        
        struct ViewModel {
            var code: String
            var message: String
        }
    }
    
    struct CurrencyCard {
        var symbol: String?
        var code: String?
        var name: String?
        var amount: String?
    }
}

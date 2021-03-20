//
//  SelectCurrency.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SelectCurrencyMode {
    case fromButton(button: SelectCurrencyButton)
    case manual
}

struct SelectCurrency {
    
    //MARK: Use Cases
    struct GetCurrencies {
        struct Request {
            
        }
        
        struct Response {
            var currencies: [CurrencyDetail]?
            var rates: [RateDetail]?
        }
        
        struct ViewModel {
            var currencies: [SelectCurrency.Currency]?
        }
    }
    
    struct SetSearchState {
        struct Request {
            var searching: Bool
        }
        
        struct Response {}
        
        struct ViewModel {}
    }
    
    struct Search {
        struct Request {
            var text: String
        }
        
        struct Response {
            var currencies: [CurrencyDetail]?
            var rates: [RateDetail]?
        }
        
        struct ViewModel {
            var currencies: [SelectCurrency.Currency]?
        }
    }
    
    struct QueryCurrencyToExecute {
        struct Request {
            var code: String
        }
        
        struct Response {
            var currency: CurrencyDetail
            var rate: RateDetail
        }
        
        struct ViewModel {
            var currency: CurrencyDetail
            var rate: RateDetail
        }
    }
    
    struct Currency {
        var flag: String?
        var flagFontSize: CGFloat
        var code: String?
        var name: String?
        var symbol: String?
        var rate: String?
    }
    
    enum Mode {
        case fromButton(button: SelectCurrencyButton)
        case manual
    }
}

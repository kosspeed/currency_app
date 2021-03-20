//
//  CurrencyError.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

class CurrencyError: Error {
    var detail: CurrencyErrorDetail
    
    init(detail: CurrencyErrorDetail) {
        self.detail = detail
    }
}

struct CurrencyErrorDetail {
    var code: Int
    var message: String
}

//MARK: Logics
extension CurrencyError {
    static func defaultError(message: String) -> CurrencyError {
        let detail = CurrencyErrorDetail(code: 9999, message: message)
        
        return CurrencyError(detail: detail)
    }
}

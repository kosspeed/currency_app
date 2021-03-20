//
//  CurrencyErrorResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

class CurrencyErrorResponse: BaseResponse {
    var valid: Bool?
    var updated: Int64?
    var error: CurrencyErrorDetailResponse?
}

class CurrencyErrorDetailResponse: Decodable {
    var code: Int?
    var message: String?
    
    init(code: Int, message: String) {
        self.code = code
        self.message = message
    }
}

//MARK: Transform
extension CurrencyErrorResponse {
    var entity: CurrencyError {
        let detail = CurrencyErrorDetail(code: error?.code ?? 0,
                                         message: error?.message ?? "")
        
        return CurrencyError(detail: detail)
    }
}

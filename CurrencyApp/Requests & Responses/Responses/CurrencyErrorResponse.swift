//
//  CurrencyErrorResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

class CurrencyErrorResponse: BaseResponse {
    var error: CurrencyErrorDetailResponse?
}

struct CurrencyErrorDetailResponse: Decodable {
    var code: Int?
    var message: String?
}

//MARK: Transform
extension CurrencyErrorResponse {
    var entity: CurrencyError {
        let detail = CurrencyErrorDetail(code: error?.code ?? 0,
                                         message: error?.message ?? "")
        
        return CurrencyError(detail: detail)
    }
}

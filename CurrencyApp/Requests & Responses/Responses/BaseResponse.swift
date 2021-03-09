//
//  BaseResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class BaseResponse: Decodable {
    var valid: Bool?
    var updated: Int64?
}

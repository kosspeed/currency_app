//
//  GetConversionResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetConversionResponse: BaseResponse {
    var valid: Bool?
    var updated: Int64?
    var conversion: ConversionResponse?
}

class ConversionResponse: Decodable {
    var from: String?
    var to: String?
    var amount: Double?
    var result: Double?
    
    init(from: String, to: String, amount: Double, result: Double) {
        self.from = from
        self.to = to
        self.amount = amount
        self.result = result
    }
}

//MARK: Transform
extension GetConversionResponse {
    var entity: Conversion {
        return Conversion(valid: valid ?? false,
                          from: conversion?.from ?? "",
                          to: conversion?.to ?? "",
                          amount: conversion?.amount ?? 0,
                          result: conversion?.result ?? 0)
    }
}

//
//  CurrencyAPI.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation
import Moya

enum CurrencyAPI {
    case getCurrencies(request: GetCurrenciesRequest)
    case getRates(request: GetRatesRequest)
    case getConversion(request: GetConversionRequest)
}

//MARK: TargetType
extension CurrencyAPI: TargetType {
    var baseURL: URL {
        let config: Config
        
        switch self {
        case .getCurrencies(let request):
            config = request.config
        case .getRates(let request):
            config = request.config
        case .getConversion(let request):
            config = request.config
        }
        
        return URL(string: config.baseURL) ?? URL(target: self)
    }
    
    var path: String {
        switch self {
        case .getCurrencies:
            return "/api/v1/currencies"
        case .getRates:
            return "/api/v1/rates"
        case .getConversion:
            return "/api/v1/convert"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrencies: return .get
        case .getRates: return .get
        case .getConversion: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getCurrencies(let request):
            return .requestCompositeParameters(bodyParameters: [:],
                                               bodyEncoding: URLEncoding.default,
                                               urlParameters: request.urlParameters)
        case .getRates(let request):
            return .requestCompositeParameters(bodyParameters: [:],
                                               bodyEncoding: URLEncoding.default,
                                               urlParameters: request.urlParameters)
        case .getConversion(let request):
            return .requestCompositeParameters(bodyParameters: [:],
                                               bodyEncoding: URLEncoding.default,
                                               urlParameters: request.urlParameters)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

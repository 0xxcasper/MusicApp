//
//  NetworkRequest.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
 
let BASE_URL = "https://www.googleapis.com/youtube/v3/"

typealias RequestSuccess = (_ data: Data) -> Void
typealias RequestFailure = (_ error: Error) -> Void

struct SuccessHandler<T> {
    typealias object = (_ object: T?) -> Void
    typealias array = (_ array: [T]) -> Void
    typealias anyObject = (_ object: Any?) -> Void
}

// NetworkPotocol
protocol NetworkRequestProtocol {
    
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure)
}
 
struct NetworkRequest: NetworkRequestProtocol {
    
    func requestData(endPoint: EndPointType, success: @escaping RequestSuccess, failure: @escaping RequestFailure) {

        let url = makeUrl(path: endPoint.path)
        let encoding = getAlamofireEncoding(httpMethod: endPoint.httpMethod)

        let request = Alamofire.request(url, method: endPoint.httpMethod, parameters: endPoint.parameters, encoding: encoding, headers: endPoint.headers)
        request.responseData { (dataResponse) in
            switch dataResponse.result {
            case .success(let data):
                success(data)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

// MARK: helper NetworkRequest
extension NetworkRequest {
    
    private func getAlamofireEncoding(httpMethod: HTTPMethod) -> ParameterEncoding {
        switch httpMethod {
        case .get:
            return URLEncoding.default
        case .post:
            return JSONEncoding.default
        default:
            return JSONEncoding.default
        }
    }

    private func makeUrl(path: String) -> String {
        return "\(BASE_URL)\(path)"
    }
}

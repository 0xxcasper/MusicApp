//
//  EndpointType.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import Foundation
import Alamofire

typealias JSONDictionary = [String: Any]

protocol EndPointType {
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: JSONDictionary { get }
    var headers: HTTPHeaders? { get }
}

struct DefaultHeader {
    
    func addDefaultHeader() -> [String: String] {
        let header: [String: String] = ["Content-Type":"application/json"]
        
        return header
    }
    
}

//
//  Provider.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

class Provider {
    static let shared = Provider()
    
    private let request: NetworkRequestProtocol = NetworkRequest()
    
    func callApiTrendingVideo(pageToken: String, maxResult: Int = 5, success: @escaping (_ response: BaseResponse) -> Void, failure: @escaping (_ message: String) -> Void) {
        let endPoint: YouTubeEndPoint = .getListTrendingMusic(pageToken: pageToken, maxResult: maxResult)
        self.request.requestData(endPoint: endPoint, success: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let baseResponse = try jsonDecoder.decode(BaseResponse.self, from: data)
                success(baseResponse)
            } catch _ as NSError {
                failure("Can't parse JSON")
            }
        }) { (Error) in
            failure("An error occurred, please try again")
        }
    }
}

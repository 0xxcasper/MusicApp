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
    
    func callApiGetVideo(id: String, success: @escaping (_ response: Item) -> Void, failure: @escaping (_ message: String) -> Void) {
        let endPoint: YouTubeEndPoint = .getVideoWith(id: id)
        self.request.requestData(endPoint: endPoint, success: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let response = try jsonDecoder.decode(VideosResponse.self, from: data)
                if let items = response.items, let item = items.first {
                    success(item)
                }
            } catch _ as NSError {
                failure("Can't parse JSON")
            }
        }) { (Error) in
            failure("An error occurred, please try again")
        }
    }
    
    func callApiTrendingVideo(pageToken: String, maxResult: Int = 5, success: @escaping (_ response: VideosResponse) -> Void, failure: @escaping (_ message: String) -> Void) {
        let endPoint: YouTubeEndPoint = .getListTrendingMusic(pageToken: pageToken, maxResult: maxResult)
        self.request.requestData(endPoint: endPoint, success: { (data) in
            do {
                let jsonDecoder = JSONDecoder()
                let baseResponse = try jsonDecoder.decode(VideosResponse.self, from: data)
                success(baseResponse)
            } catch _ as NSError {
                failure("Can't parse JSON")
            }
        }) { (Error) in
            failure("An error occurred, please try again")
        }
    }
    
    func callApiGetListVideo(pageToken: String, maxResult: Int = 5, keyword: String, success: @escaping (_ response: SearchResponse) -> Void, failure: @escaping (_ message: String) -> Void) {
        let endPoint: YouTubeEndPoint = .getListMusicWith(pageToken: pageToken, maxResult: maxResult, keyword: keyword)
//        self.request.requestData(endPoint: endPoint, success: { (data) in
//            do {
//                let jsonDecoder = JSONDecoder()
//                let baseResponse = try jsonDecoder.decode(SearchResponse.self, from: data)
//                success(baseResponse)
//            } catch _ as NSError {
//                failure("Can't parse JSON")
//            }
//        }) { (Error) in
//            failure("An error occurred, please try again")
//        }
    }
}

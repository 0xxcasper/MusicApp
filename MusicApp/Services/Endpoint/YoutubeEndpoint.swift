//
//  YoutubeEndpoint.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import Alamofire

enum YouTubeEndPoint {
    case getListTrendingMusic(pageToken: String, maxResult: Int)
}

extension YouTubeEndPoint: EndPointType
{
    var path: String {
        switch self {
        case .getListTrendingMusic:
           return "videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListTrendingMusic:
            return .get
        }
    }
    
    var parameters: JSONDictionary {
        switch self {
        case .getListTrendingMusic(let pageToken, let maxResult):
            return ["part": "snippet",
                    "chart": "mostPopular",
                    "regionCode": "VN",
                    "maxResults": maxResult,
                    "key": key,
                    "videoCategoryId": 10,
                    "pageToken": pageToken]
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addDefaultHeader()
    }
}

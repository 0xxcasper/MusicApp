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
    case getListMusicWith(pageToken: String, maxResult: Int, keyword: String)
}

extension YouTubeEndPoint: EndPointType
{
    var path: String {
        switch self {
        case .getListTrendingMusic:
           return "videos"
        case .getListMusicWith:
            return "search"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getListTrendingMusic, .getListMusicWith:
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
        case .getListMusicWith(let pageToken, let maxResult, let keyword):
            return ["part": "snippet",
                    "maxResults": maxResult,
                    "regionCode": "VN",
                    "pageToken": pageToken,
                    "q": keyword,
                    "key": key]
        }
    }
    
    var headers: HTTPHeaders? {
        return DefaultHeader().addDefaultHeader()
    }
}

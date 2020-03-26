//
//  VideosResponse.swift
//  MusicApp
//
//  Created by admin on 26/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

class VideosResponse : Codable {
    let kind : String?
    let etag : String?
    let nextPageToken : String?
    let prevPageToken : String?
    let pageInfo : PageInfo?
    let items : [Item]?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case etag = "etag"
        case nextPageToken = "nextPageToken"
        case prevPageToken = "prevPageToken"
        case pageInfo = "pageInfo"
        case items = "items"
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        nextPageToken = try values.decodeIfPresent(String.self, forKey: .nextPageToken)
        prevPageToken = try values.decodeIfPresent(String.self, forKey: .prevPageToken)
        pageInfo = try values.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
        items = try values.decodeIfPresent([Item].self, forKey: .items)
    }
}

struct Item : Codable {
    let kind : String?
    let etag : String?
    let id : String?
    let snippet : Snippet?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case etag = "etag"
        case id = "id"
        case snippet = "snippet"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        snippet = try values.decodeIfPresent(Snippet.self, forKey: .snippet)
    }

}

struct PageInfo : Codable {
    let totalResults : Int?
    let resultsPerPage : Int?

    enum CodingKeys: String, CodingKey {

        case totalResults = "totalResults"
        case resultsPerPage = "resultsPerPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalResults = try values.decodeIfPresent(Int.self, forKey: .totalResults)
        resultsPerPage = try values.decodeIfPresent(Int.self, forKey: .resultsPerPage)
    }

}


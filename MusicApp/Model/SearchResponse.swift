//
//  SearchResponse.swift
//  MusicApp
//
//  Created by admin on 26/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

struct SearchResponse : Codable {
    let kind : String?
    let etag : String?
    let nextPageToken : String?
    let prevPageToken : String?
    let pageInfo : PageInfo?
    let items : [ItemSearch]?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case etag = "etag"
        case nextPageToken = "nextPageToken"
        case prevPageToken = "prevPageToken"
        case pageInfo = "pageInfo"
        case items = "items"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        etag = try values.decodeIfPresent(String.self, forKey: .etag)
        nextPageToken = try values.decodeIfPresent(String.self, forKey: .nextPageToken)
        prevPageToken = try values.decodeIfPresent(String.self, forKey: .prevPageToken)
        pageInfo = try values.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
        items = try values.decodeIfPresent([ItemSearch].self, forKey: .items)
    }
}

struct ItemSearch : Codable {
    let kind : String?
    let etag : String?
    let id : ID?
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
        id = try values.decodeIfPresent(ID.self, forKey: .id)
        snippet = try values.decodeIfPresent(Snippet.self, forKey: .snippet)
    }

}


struct ID : Codable {
    let kind : String?
    let videoId : String?

    enum CodingKeys: String, CodingKey {

        case kind = "kind"
        case videoId = "videoId"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        videoId = try values.decodeIfPresent(String.self, forKey: .videoId)

    }
}

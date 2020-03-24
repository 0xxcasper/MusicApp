//
//  Snippet.swift
//  MusicApp
//
//  Created by admin on 24/03/2020.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation

struct Snippet : Codable {
    let publishedAt : String?
    let channelId : String?
    let title : String?
    let description : String?
    let thumbnails : Thumbnails?
    let channelTitle : String?
    let tags : [String]?
    let categoryId : String?
    let liveBroadcastContent : String?
    let defaultLanguage : String?
    let localized : Localized?
    let defaultAudioLanguage : String?

    enum CodingKeys: String, CodingKey {

        case publishedAt = "publishedAt"
        case channelId = "channelId"
        case title = "title"
        case description = "description"
        case thumbnails = "thumbnails"
        case channelTitle = "channelTitle"
        case tags = "tags"
        case categoryId = "categoryId"
        case liveBroadcastContent = "liveBroadcastContent"
        case defaultLanguage = "defaultLanguage"
        case localized = "localized"
        case defaultAudioLanguage = "defaultAudioLanguage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        channelId = try values.decodeIfPresent(String.self, forKey: .channelId)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        thumbnails = try values.decodeIfPresent(Thumbnails.self, forKey: .thumbnails)
        channelTitle = try values.decodeIfPresent(String.self, forKey: .channelTitle)
        tags = try values.decodeIfPresent([String].self, forKey: .tags)
        categoryId = try values.decodeIfPresent(String.self, forKey: .categoryId)
        liveBroadcastContent = try values.decodeIfPresent(String.self, forKey: .liveBroadcastContent)
        defaultLanguage = try values.decodeIfPresent(String.self, forKey: .defaultLanguage)
        localized = try values.decodeIfPresent(Localized.self, forKey: .localized)
        defaultAudioLanguage = try values.decodeIfPresent(String.self, forKey: .defaultAudioLanguage)
    }

}

struct Localized : Codable {
    let title : String?
    let description : String?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case description = "description"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }

}

struct Thumbnails : Codable {
    let defaults : Standard?
    let medium : Standard?
    let high : Standard?
    let standard : Standard?
    let maxres : Standard?

    enum CodingKeys: String, CodingKey {

        case defaults = "default"
        case medium = "medium"
        case high = "high"
        case standard = "standard"
        case maxres = "maxres"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        defaults = try values.decodeIfPresent(Standard.self, forKey: .defaults)
        medium = try values.decodeIfPresent(Standard.self, forKey: .medium)
        high = try values.decodeIfPresent(Standard.self, forKey: .high)
        standard = try values.decodeIfPresent(Standard.self, forKey: .standard)
        maxres = try values.decodeIfPresent(Standard.self, forKey: .maxres)
    }

}

struct Standard : Codable {
    let url : String?
    let width : Int?
    let height : Int?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case width = "width"
        case height = "height"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
    }
}

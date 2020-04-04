//
//  PlaylistModel.swift
//  MusicApp
//
//  Created by Sang on 4/4/20.
//  Copyright © 2020 SangNX. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers class PlaylistModel: Object {
    enum Property: String {
        case id, name, items
    }
    
    dynamic var id = UUID().uuidString
    dynamic var name = ""
    dynamic var items: [ItemPlayList] = []

    override static func primaryKey() -> String? {
        return PlaylistModel.Property.id.rawValue
    }
    
    convenience init(_ name: String, item: ItemPlayList? = nil) {
        self.init()
        self.name = name
        if(item != nil) {
            self.items.append(item!)
        }
    }
}

extension PlaylistModel {
    static func add(name: String, item: ItemPlayList? = nil, in realm: Realm = try! Realm()) -> PlaylistModel {
        let playList = PlaylistModel(name, item: item)
        try! realm.write {
            realm.add(playList)
        }
        return playList
    }
    
    static func getAll(in realm: Realm = try! Realm()) -> Results<PlaylistModel> {
        return realm.objects(PlaylistModel.self)
    }
    
    func editName(name: String) {
        guard let realm = realm else { return }
        try! realm.write {
            self.name = name
        }
    }
    
    func addItem(item: ItemPlayList) {
        guard let realm = realm else { return }
        try! realm.write {
            self.items.append(item)
        }
    }
    
    func removeItem(item: ItemPlayList) {
        guard let realm = realm else { return }
        try! realm.write {
            for (index, value) in self.items.enumerated() {
                if(value.id == item.id) {
                    items.remove(at: index)
                }
            }
        }
    }
    
    func delete() {
        guard let realm = realm else { return }
        try! realm.write {
            realm.delete(self)
        }
    }
    
}


class ItemPlayList {
    var name: String = ""
    var id: String = ""
    var thumbnail: String = ""
    var channelTitle: String = ""
    
    init(name: String, id: String, thumbnail: String, channelTitle: String) {
        self.name = name
        self.id = id
        self.thumbnail = thumbnail
        self.channelTitle = channelTitle
    }
}
